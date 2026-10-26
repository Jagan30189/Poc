#ifndef MEDICAL_H
#define MEDICAL_H

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

extern MedicalItem inventory[MAX_ITEMS];
extern SupplyRequest requests[MAX_REQUESTS];
extern Distribution distributions[MAX_DISTRIBUTIONS];
extern int itemCount;
extern int requestCount;
extern int distributionCount;

int findItem(int id);
void addItem(void);
void viewInventory(void);
void searchItem(void);
void updateItem(void);
void deleteItem(void);
void receiveStock(void);
void lowStockItems(void);
void outOfStockItems(void);
void createRequest(void);
void processRequest(void);
void viewRequests(void);
void distributeSupply(void);
void viewDistributionHistory(void);

#endif
