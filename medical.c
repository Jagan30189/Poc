#include "medical.h"

#include <limits.h>
#include <stdio.h>
#include <string.h>
#include <time.h>


MedicalItem inventory[MAX_ITEMS];

SupplyRequest requests[MAX_REQUESTS];

Distribution distributions[MAX_DISTRIBUTIONS];


int itemCount = 0;

int requestCount = 0;

int distributionCount = 0;

static void currentDate(char date[20]) {

    time_t now = time(NULL);
    const struct tm *local = localtime(&now);

    if(local == NULL) {
        date[0] = '\0';
        return;
    }

    if(strftime(date, 20, "%d-%m-%Y %H:%M:%S", local) == 0)
        date[0] = '\0';
}

static void logEvent(const char *event) {
    FILE *log = fopen("medical.log", "a");
    char timestamp[20];

    if(log == NULL) {
        fprintf(stderr, "Warning: unable to open medical.log\n");
        return;
    }

    currentDate(timestamp);
    if(fprintf(log, "[%s] %s\n", timestamp, event) < 0)
        fprintf(stderr, "Warning: unable to write medical.log\n");
    if(fclose(log) != 0)
        fprintf(stderr, "Warning: unable to close medical.log\n");
}

int validateDate(const char *date) {
    int day, month, year;
    char extra;
    struct tm candidate = {0};

    if(date == NULL || sscanf(date, "%2d/%2d/%4d%c",
                              &day, &month, &year, &extra) != 3)
        return 0;
    if(year < 1900 || month < 1 || month > 12 || day < 1 || day > 31)
        return 0;

    candidate.tm_year = year - 1900;
    candidate.tm_mon = month - 1;
    candidate.tm_mday = day;
    candidate.tm_isdst = -1;
    mktime(&candidate);
    return candidate.tm_year == year - 1900 &&
           candidate.tm_mon == month - 1 &&
           candidate.tm_mday == day;
}


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

    if(value[0] == '\0') {
        printf("Value cannot be empty.\n");
        return 0;
    }
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

    if(!validateDate(inventory[itemCount].expiryDate)) {
        printf("Invalid date. Use DD/MM/YYYY.\n");
        return;
    }

    currentDate(inventory[itemCount].createdDate);
    memcpy(inventory[itemCount].updatedDate,
           inventory[itemCount].createdDate,
           sizeof(inventory[itemCount].updatedDate));

    itemCount++;
    logEvent("Inventory item added");
    printf("Item Added Successfully at %s!\n",
           inventory[itemCount - 1].createdDate);
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

        printf("\nExpiry Date: %s", inventory[i].expiryDate);

        printf("\nCreated Date: %s", inventory[i].createdDate);

        printf("\nUpdated Date: %s\n", inventory[i].updatedDate);

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

    if(!validateDate(inventory[index].expiryDate)) {
        printf("Invalid date. Use DD/MM/YYYY.\n");
        return;
    }

    inventory[index].quantity = newQuantity;
    currentDate(inventory[index].updatedDate);
    logEvent("Inventory item updated");
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


    if(qty > INT_MAX - inventory[index].quantity) {
        printf("Quantity exceeds the supported limit.\n");
        return;
    }

    inventory[index].quantity += qty;
    currentDate(inventory[index].updatedDate);
    logEvent("Inventory stock received");


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

    currentDate(requests[requestCount].createdDate);
    requests[requestCount].processedDate[0] = '\0';

    snprintf(requests[requestCount].status,
             sizeof(requests[requestCount].status), "%s", "Pending");


    requestCount++;
    logEvent("Supply request created");


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

                snprintf(requests[i].status, sizeof(requests[i].status),
                         "%s", "Rejected");
                currentDate(requests[i].processedDate);
                logEvent("Supply request rejected: item not found");

                printf("Item Not Found.\n");

                return;

            }


            if(inventory[index].quantity >= requests[i].quantity) {

                snprintf(requests[i].status, sizeof(requests[i].status),
                         "%s", "Approved");
                currentDate(requests[i].processedDate);
                logEvent("Supply request approved");

                printf("Request Approved.\n");

            }

            else {

                snprintf(requests[i].status, sizeof(requests[i].status),
                         "%s", "Rejected");
                currentDate(requests[i].processedDate);
                logEvent("Supply request rejected: insufficient stock");

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

        printf("\nStatus     : %s", requests[i].status);

        printf("\nCreated Date : %s", requests[i].createdDate);

        printf("\nProcessed Date: %s\n", requests[i].processedDate);

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


            snprintf(distributions[distributionCount].itemName,
                     sizeof(distributions[distributionCount].itemName), "%s",
                     inventory[itemIndex].name);


            distributions[distributionCount].quantity =

            requests[i].quantity;


            snprintf(distributions[distributionCount].department,
                     sizeof(distributions[distributionCount].department), "%s",
                     requests[i].department);

            currentDate(distributions[distributionCount].distributedDate);

            distributionCount++;

            snprintf(requests[i].status, sizeof(requests[i].status),
                     "%s", "Distributed");
            logEvent("Supply request distributed");


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

        printf("Distributed Date: %s\n",

               distributions[i].distributedDate);

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