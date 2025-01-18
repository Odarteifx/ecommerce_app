class PaystackConst {
  // API Endpoints - Customers
  static const String createCustomer = 'https://api.paystack.co/customer';
  static const String listCustomers = 'https://api.paystack.co/customer';
  static String fetchCustomer(String emailOrCode) => 'https://api.paystack.co/customer/$emailOrCode';
  static String updateCustomer(String code) => 'https://api.paystack.co/customer/$code';


// API Endpoints - Transactions
static const String intializeTransaction = 'https://api.paystack.co/transaction/initialize';
static String verifyTransaction(String reference) => 'https://api.paystack.co/transaction/verify/$reference';
static const listTransactions = 'https://api.paystack.co/transaction';
}