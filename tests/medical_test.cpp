#include <gtest/gtest.h>

#include <climits>
#include <cstdio>
#include <cstring>
#include <functional>
#include <string>

#include <unistd.h>

extern "C" {
#include "medical.h"
}

namespace {

class MedicalTest : public ::testing::Test {
protected:
    void SetUp() override {
            setvbuf(stdin, nullptr, _IONBF, 0);
        std::memset(inventory, 0, sizeof(inventory));
        std::memset(requests, 0, sizeof(requests));
        std::memset(distributions, 0, sizeof(distributions));
        itemCount = 0;
        requestCount = 0;
        distributionCount = 0;
    }

    void Input(const std::string& value, const std::function<void()>& action) {
        FILE* input = std::tmpfile();
        ASSERT_NE(input, nullptr);
        fputs(value.c_str(), input);
        rewind(input);

        int savedStdin = dup(STDIN_FILENO);
        ASSERT_GE(savedStdin, 0);
        ASSERT_EQ(dup2(fileno(input), STDIN_FILENO), STDIN_FILENO);
        action();
        ASSERT_EQ(dup2(savedStdin, STDIN_FILENO), STDIN_FILENO);
        close(savedStdin);
        fclose(input);
    }

    void AddItemDirect(int id, const char* name, int quantity) {
        inventory[itemCount].itemID = id;
        std::strncpy(inventory[itemCount].name, name,
                     sizeof(inventory[itemCount].name) - 1);
        std::strncpy(inventory[itemCount].category, "General",
                     sizeof(inventory[itemCount].category) - 1);
        inventory[itemCount].quantity = quantity;
        std::strncpy(inventory[itemCount].expiryDate, "31/12/2027",
                     sizeof(inventory[itemCount].expiryDate) - 1);
        ++itemCount;
    }
};

TEST_F(MedicalTest, AddsAndFindsItem) {
    Input("101\nGloves\nPPE\n5\n31/12/2027\n", [] { addItem(); });

    ASSERT_EQ(itemCount, 1);
    EXPECT_EQ(findItem(101), 0);
    EXPECT_EQ(findItem(999), -1);
    EXPECT_STREQ(inventory[0].name, "Gloves");
    EXPECT_EQ(inventory[0].quantity, 5);
    EXPECT_EQ(std::strlen(inventory[0].createdDate), 19);
    EXPECT_STREQ(inventory[0].createdDate, inventory[0].updatedDate);
}

TEST_F(MedicalTest, RejectsInvalidAndDuplicateItems) {
    Input("101\nGloves\nPPE\n-1\n", [] { addItem(); });
    EXPECT_EQ(itemCount, 0);

    Input("101\nGloves\nPPE\n5\n31/12/2027\n", [] { addItem(); });
    Input("101\nOther\nPPE\n5\n31/12/2027\n", [] { addItem(); });
    EXPECT_EQ(itemCount, 1);

    Input("bad\n", [] { addItem(); });
    EXPECT_EQ(itemCount, 1);
}

TEST_F(MedicalTest, RejectsEmptyAndInvalidDates) {
    Input("101\n\n", [] { addItem(); });
    EXPECT_EQ(itemCount, 0);

    Input("101\nGloves\nPPE\n5\n31/02/2027\n", [] { addItem(); });
    EXPECT_EQ(itemCount, 0);
    EXPECT_EQ(validateDate("29/02/2028"), 1);
    EXPECT_EQ(validateDate("29/02/2027"), 0);
}

TEST_F(MedicalTest, HandlesInventoryCapacityAndViews) {
    for(int i = 0; i < MAX_ITEMS; ++i)
        AddItemDirect(i + 1, "Item", i % 2);

    Input("1001\n", [] { addItem(); });
    EXPECT_EQ(itemCount, MAX_ITEMS);

    viewInventory();
    lowStockItems();
    outOfStockItems();
}

TEST_F(MedicalTest, SearchesUpdatesAndDeletesItems) {
    AddItemDirect(101, "Gloves", 5);
    AddItemDirect(102, "Masks", 0);

    Input("101\n", [] { searchItem(); });
    Input("999\n", [] { searchItem(); });
    Input("bad\n", [] { searchItem(); });

    Input("101\n8\n30/06/2028\n", [] { updateItem(); });
    EXPECT_EQ(inventory[0].quantity, 8);
    EXPECT_STREQ(inventory[0].expiryDate, "30/06/2028");
    EXPECT_EQ(std::strlen(inventory[0].updatedDate), 19);

    Input("101\n-2\n", [] { updateItem(); });
    EXPECT_EQ(inventory[0].quantity, 8);
    Input("999\n", [] { updateItem(); });

    Input("101\n", [] { deleteItem(); });
    EXPECT_EQ(itemCount, 1);
    EXPECT_EQ(inventory[0].itemID, 102);
    Input("999\n", [] { deleteItem(); });
}

TEST_F(MedicalTest, RejectsInvalidUpdateAndStockInput) {
    AddItemDirect(101, "Gloves", 5);

    Input("101\nbad\n", [] { updateItem(); });
    Input("101\n8\n\n", [] { updateItem(); });
    Input("101\n8\n31/02/2027\n", [] { updateItem(); });
    EXPECT_EQ(inventory[0].quantity, 5);

    Input("bad\n", [] { deleteItem(); });
    Input("bad\n", [] { receiveStock(); });
    EXPECT_EQ(inventory[0].quantity, 5);
}

TEST_F(MedicalTest, CoversEmptyViewsAndRejectedInputs) {
    viewInventory();
    lowStockItems();
    outOfStockItems();

    Input("101\nGloves\n\n", [] { addItem(); });
    EXPECT_EQ(itemCount, 0);

    Input("101\nbad\n", [] { createRequest(); });
    Input("101\n101\nbad\n", [] { createRequest(); });
    EXPECT_EQ(requestCount, 0);

    Input("bad\n", [] { distributeSupply(); });
    EXPECT_EQ(distributionCount, 0);
}

TEST_F(MedicalTest, CoversAdditionalInputFailures) {
    AddItemDirect(101, "Gloves", 5);

    Input("101\nbad\n", [] { receiveStock(); });
    Input("101\nbad\n", [] { createRequest(); });
    Input("101\n101\n1\n\n", [] { createRequest(); });
    EXPECT_EQ(requestCount, 0);

    Input("101\nGloves\nPPE\nbad\n", [] { addItem(); });
    EXPECT_EQ(itemCount, 1);
}

TEST_F(MedicalTest, ReceivesStockAndRejectsInvalidQuantities) {
    AddItemDirect(101, "Gloves", 5);

    Input("101\n4\n", [] { receiveStock(); });
    EXPECT_EQ(inventory[0].quantity, 9);
    Input("101\n0\n", [] { receiveStock(); });
    Input("101\n-1\n", [] { receiveStock(); });
    Input("999\n4\n", [] { receiveStock(); });
    EXPECT_EQ(inventory[0].quantity, 9);
}

TEST_F(MedicalTest, RejectsStockIntegerOverflow) {
    AddItemDirect(101, "Gloves", INT_MAX);

    Input("101\n1\n", [] { receiveStock(); });
    EXPECT_EQ(inventory[0].quantity, INT_MAX);
}

TEST_F(MedicalTest, CreatesAndProcessesRequests) {
    AddItemDirect(101, "Gloves", 5);

    Input("501\n101\n3\nEmergency\n", [] { createRequest(); });
    ASSERT_EQ(requestCount, 1);
    EXPECT_STREQ(requests[0].status, "Pending");
    EXPECT_EQ(std::strlen(requests[0].createdDate), 19);
    EXPECT_STREQ(requests[0].processedDate, "");

    Input("501\n", [] { processRequest(); });
    EXPECT_STREQ(requests[0].status, "Approved");
    EXPECT_EQ(std::strlen(requests[0].processedDate), 19);

    Input("999\n", [] { processRequest(); });
    Input("bad\n", [] { processRequest(); });

    Input("502\n101\n99\nWard\n", [] { createRequest(); });
    Input("502\n", [] { processRequest(); });
    EXPECT_STREQ(requests[1].status, "Rejected");

    Input("503\n999\n1\nWard\n", [] { createRequest(); });
    Input("503\n", [] { processRequest(); });
    EXPECT_STREQ(requests[2].status, "Rejected");
}

TEST_F(MedicalTest, RejectsInvalidAndDuplicateRequests) {
    AddItemDirect(101, "Gloves", 5);

    Input("501\n101\n0\nWard\n", [] { createRequest(); });
    EXPECT_EQ(requestCount, 0);
    Input("501\n101\n2\nWard\n", [] { createRequest(); });
    Input("501\n101\n2\nWard\n", [] { createRequest(); });
    EXPECT_EQ(requestCount, 1);

    requestCount = MAX_REQUESTS;
    Input("999\n101\n1\nWard\n", [] { createRequest(); });
    EXPECT_EQ(requestCount, MAX_REQUESTS);
    viewRequests();
}

TEST_F(MedicalTest, DistributesApprovedRequestOnlyOnce) {
    AddItemDirect(101, "Gloves", 5);
    Input("501\n101\n3\nEmergency\n", [] { createRequest(); });
    Input("501\n", [] { processRequest(); });

    Input("501\n", [] { distributeSupply(); });
    ASSERT_EQ(distributionCount, 1);
    EXPECT_EQ(inventory[0].quantity, 2);
    EXPECT_STREQ(requests[0].status, "Distributed");
    EXPECT_EQ(std::strlen(distributions[0].distributedDate), 19);

    Input("501\n", [] { distributeSupply(); });
    EXPECT_EQ(distributionCount, 1);
    viewDistributionHistory();
}

TEST_F(MedicalTest, RejectsInvalidDistributions) {
    AddItemDirect(101, "Gloves", 5);
    Input("501\n101\n4\nEmergency\n", [] { createRequest(); });
    Input("501\n", [] { distributeSupply(); });
    Input("999\n", [] { distributeSupply(); });

    requestCount = 1;
    std::strcpy(requests[0].status, "Approved");
    requests[0].itemID = 999;
    Input("501\n", [] { distributeSupply(); });

    requests[0].itemID = 101;
    requests[0].quantity = 99;
    Input("501\n", [] { distributeSupply(); });

    distributionCount = MAX_DISTRIBUTIONS;
    Input("501\n", [] { distributeSupply(); });
    EXPECT_EQ(distributionCount, MAX_DISTRIBUTIONS);
}

}  // namespace
