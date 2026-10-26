#include <stdio.h>

#include <string.h>


#define MAX_ITEMS 100

#define MAX_REQUESTS 100

#define MAX_DISTRIBUTIONS 100


typedef struct {

    int itemID;

    char name[50];

    char category[30];

    int quantity;

    char expiryDate[15];

} MedicalItem;


typedef struct {

    int requestID;

    int itemID;

    int quantity;

    char department[50];

    char status[20];

} SupplyRequest;


typedef struct {

    int distributionID;

    int itemID;

    char itemName[50];

    int quantity;

    char department[50];

} Distribution;


MedicalItem inventory[MAX_ITEMS];

SupplyRequest requests[MAX_REQUESTS];

Distribution distributions[MAX_DISTRIBUTIONS];


int itemCount = 0;

int requestCount = 0;

int distributionCount = 0;


void discardInput() {

    int character;

    while((character = getchar()) != '\n' && character != EOF) {
    }

}


int readInt(const char *prompt, int *value) {

    printf("%s", prompt);

    if(scanf("%d", value) != 1) {

        discardInput();

        printf("Invalid number.\n");

        return 0;

    }

    discardInput();

    return 1;

}


int readText(const char *prompt, char *value, int size) {

    size_t length;

    printf("%s", prompt);

    if(fgets(value, size, stdin) == NULL)
        return 0;

    length = strlen(value);

    if(length > 0 && value[length - 1] == '\n')
        value[length - 1] = '\0';
    else
        discardInput();

    return 1;

}


int findItem(int id) {

    int i;

    for(i = 0; i < itemCount; i++) {

        if(inventory[i].itemID == id)

            return i;

    }

    return -1;

}


/* Inventory Management */


void addItem() {

    if(itemCount >= MAX_ITEMS) {
        printf("Inventory Full!\n");
        return;
    }

    if(!readInt("Enter Item ID: ", &inventory[itemCount].itemID))
        return;

    if(findItem(inventory[itemCount].itemID) != -1) {
        printf("Item ID already exists!\n");
        return;
    }

    if(!readText("Enter Item Name: ", inventory[itemCount].name,
                 sizeof(inventory[itemCount].name)))
        return;

    if(!readText("Enter Category: ", inventory[itemCount].category,
                 sizeof(inventory[itemCount].category)))
        return;

    if(!readInt("Enter Quantity: ", &inventory[itemCount].quantity))
        return;

    if(inventory[itemCount].quantity < 0) {
        printf("Quantity cannot be negative!\n");
        return;
    }

    if(!readText("Enter Expiry Date (DD/MM/YYYY): ",
                 inventory[itemCount].expiryDate,
                 sizeof(inventory[itemCount].expiryDate)))
        return;

    itemCount++;
    printf("Item Added Successfully!\n");
}


void viewInventory() {

    int i;


    if(itemCount == 0) {

        printf("No Inventory Records Found!\n");

        return;

    }


    printf("\n----- INVENTORY -----\n");


    for(i = 0; i < itemCount; i++) {

        printf("\nID: %d", inventory[i].itemID);

        printf("\nName: %s", inventory[i].name);

        printf("\nCategory: %s", inventory[i].category);

        printf("\nQuantity: %d", inventory[i].quantity);

        printf("\nExpiry Date: %s\n", inventory[i].expiryDate);

    }

}


void searchItem() {

    int id, index;


    if(!readInt("Enter Item ID: ", &id))
        return;


    index = findItem(id);


    if(index == -1) {

        printf("Item Not Found!\n");

        return;

    }


    printf("\nID: %d", inventory[index].itemID);

    printf("\nName: %s", inventory[index].name);

    printf("\nCategory: %s", inventory[index].category);

    printf("\nQuantity: %d", inventory[index].quantity);

    printf("\nExpiry Date: %s\n", inventory[index].expiryDate);

}


void updateItem() {

    int id, index, newQuantity;

    if(!readInt("Enter Item ID: ", &id))
        return;

    index = findItem(id);

    if(index == -1) {
        printf("Item Not Found!\n");
        return;
    }

    if(!readInt("Enter New Quantity: ", &newQuantity))
        return;

    if(newQuantity < 0) {
        printf("Quantity cannot be negative!\n");
        return;
    }

    if(!readText("Enter New Expiry Date: ", inventory[index].expiryDate,
                 sizeof(inventory[index].expiryDate)))
        return;

    inventory[index].quantity = newQuantity;
    printf("Item Updated Successfully!\n");

}


void deleteItem() {

    int id, index, i;


    if(!readInt("Enter Item ID: ", &id))
        return;


    index = findItem(id);


    if(index == -1) {

        printf("Item Not Found!\n");

        return;

    }


    for(i = index; i < itemCount - 1; i++) {

        inventory[i] = inventory[i + 1];

    }


    itemCount--;


    printf("Item Removed Successfully!\n");

}


/* Stock Management */


void receiveStock() {

    int id, qty, index;


    if(!readInt("Enter Item ID: ", &id))
        return;


    index = findItem(id);


    if(index == -1) {

        printf("Item Not Found!\n");

        return;

    }


    if(!readInt("Enter Quantity Received: ", &qty))
        return;

    if(qty <= 0) {

        printf("Quantity must be positive!\n");

        return;

    }


    inventory[index].quantity += qty;


    printf("Stock Updated Successfully!\n");

}


void lowStockItems() {

    int i, found = 0;


    printf("\n----- LOW STOCK ITEMS -----\n");


    for(i = 0; i < itemCount; i++) {

        if(inventory[i].quantity <= 10 && inventory[i].quantity > 0) {

            printf("%d - %s (Qty: %d)\n",
                   inventory[i].itemID,
                   inventory[i].name,
                   inventory[i].quantity);

            found = 1;
        }
    }

    if(!found)

        printf("No Low Stock Items.\n");

}


void outOfStockItems() {

    int i, found = 0;


    printf("\n----- OUT OF STOCK ITEMS -----\n");


    for(i = 0; i < itemCount; i++) {

        if(inventory[i].quantity == 0) {

            printf("%d - %s\n",

                   inventory[i].itemID,

                   inventory[i].name);

            found = 1;

        }

    }


    if(!found)

        printf("No Out Of Stock Items.\n");

}


/* Supply Request Management */


void createRequest() {

    int i;

    if(requestCount >= MAX_REQUESTS) {

        printf("Request Storage Full!\n");

        return;

    }


    if(!readInt("Enter Request ID: ", &requests[requestCount].requestID))
        return;

    for(i = 0; i < requestCount; i++) {

        if(requests[i].requestID == requests[requestCount].requestID) {

            printf("Request ID already exists!\n");

            return;

        }

    }


    if(!readInt("Enter Item ID: ", &requests[requestCount].itemID))
        return;


    if(!readInt("Enter Quantity Required: ", &requests[requestCount].quantity))
        return;

    if(requests[requestCount].quantity <= 0) {

        printf("Quantity must be positive!\n");

        return;

    }


    if(!readText("Enter Department: ", requests[requestCount].department,
                 sizeof(requests[requestCount].department)))
        return;


    strcpy(requests[requestCount].status, "Pending");


    requestCount++;


    printf("Request Created Successfully!\n");

}


void processRequest() {


    int reqID;

    int i, index;


    if(!readInt("Enter Request ID: ", &reqID))
        return;


    for(i = 0; i < requestCount; i++) {


        if(requests[i].requestID == reqID) {


            index = findItem(requests[i].itemID);


            if(index == -1) {

                strcpy(requests[i].status, "Rejected");

                printf("Item Not Found.\n");

                return;

            }


            if(inventory[index].quantity >= requests[i].quantity) {

                strcpy(requests[i].status, "Approved");

                printf("Request Approved.\n");

            }

            else {

                strcpy(requests[i].status, "Rejected");

                printf("Insufficient Stock. Request Rejected.\n");

            }


            return;

        }

    }


    printf("Request Not Found.\n");

}


void viewRequests() {


    int i;


    printf("\n----- REQUESTS -----\n");


    for(i = 0; i < requestCount; i++) {

        printf("\nRequest ID : %d", requests[i].requestID);

        printf("\nItem ID    : %d", requests[i].itemID);

        printf("\nQuantity   : %d", requests[i].quantity);

        printf("\nDepartment : %s", requests[i].department);

        printf("\nStatus     : %s\n", requests[i].status);

    }

}


/* Distribution Management */


void distributeSupply() {


    int reqID;

    int i, itemIndex;


    if(distributionCount >= MAX_DISTRIBUTIONS) {

        printf("Distribution Storage Full!\n");

        return;

    }

    if(!readInt("Enter Approved Request ID: ", &reqID))
        return;


    for(i = 0; i < requestCount; i++) {


        if(requests[i].requestID == reqID) {


            if(strcmp(requests[i].status, "Approved") != 0) {

                printf("Request Is Not Approved.\n");

                return;

            }


            itemIndex = findItem(requests[i].itemID);


            if(itemIndex == -1) {

                printf("Item Not Found.\n");

                return;

            }

            if(inventory[itemIndex].quantity < requests[i].quantity) {

                printf("Insufficient Stock. Supply Not Distributed.\n");

                return;

            }


            inventory[itemIndex].quantity -= requests[i].quantity;


            distributions[distributionCount].distributionID =

            distributionCount + 1;


            distributions[distributionCount].itemID =

            requests[i].itemID;


            strcpy(distributions[distributionCount].itemName,

                   inventory[itemIndex].name);


            distributions[distributionCount].quantity =

            requests[i].quantity;


            strcpy(distributions[distributionCount].department,

                   requests[i].department);


            distributionCount++;

            strcpy(requests[i].status, "Distributed");


            printf("Supply Distributed Successfully!\n");

            return;

        }

    }


    printf("Request Not Found.\n");

}


void viewDistributionHistory() {


    int i;


    printf("\n----- DISTRIBUTION HISTORY -----\n");


    for(i = 0; i < distributionCount; i++) {


        printf("\nDistribution ID : %d",

               distributions[i].distributionID);


        printf("\nItem ID         : %d",

               distributions[i].itemID);


        printf("\nItem Name       : %s",

               distributions[i].itemName);


        printf("\nQuantity        : %d",

               distributions[i].quantity);


        printf("\nDepartment      : %s\n",

               distributions[i].department);

    }

}


/* Main Function */


#ifndef UNIT_TEST
int main() {


    int choice;


    while(1) {


        printf("\n====================================");

        printf("\n MEDICAL SUPPLY MANAGEMENT SYSTEM");

        printf("\n====================================");

        printf("\n1. Add Item");

        printf("\n2. View Inventory");

        printf("\n3. Search Item");

        printf("\n4. Update Item");

        printf("\n5. Remove Item");

        printf("\n6. Receive Stock");

        printf("\n7. Low Stock Items");

        printf("\n8. Out Of Stock Items");

        printf("\n9. Create Supply Request");

        printf("\n10. Process Request");

        printf("\n11. View Requests");

        printf("\n12. Distribute Supplies");

        printf("\n13. View Distribution History");

        printf("\n14. Exit");

        printf("\nEnter Choice: ");


        if(!readInt("", &choice))
            continue;


        switch(choice) {


            case 1: addItem(); break;

            case 2: viewInventory(); break;

            case 3: searchItem(); break;

            case 4: updateItem(); break;

            case 5: deleteItem(); break;

            case 6: receiveStock(); break;

            case 7: lowStockItems(); break;

            case 8: outOfStockItems(); break;

            case 9: createRequest(); break;

            case 10: processRequest(); break;

            case 11: viewRequests(); break;

            case 12: distributeSupply(); break;

            case 13: viewDistributionHistory(); break;


            case 14:

                printf("Exiting System...\n");

                return 0;


            default:

                printf("Invalid Choice!\n");

        }

    }


    return 0;

}
#endif