# Kuriftu Resort Backend API Endpoints

This document provides a comprehensive list of all available API endpoints in the Kuriftu Resort backend system.

## Table of Contents

- [Authentication & User Management](#authentication--user-management)
- [Room Management](#room-management)
- [Price Calculation](#price-calculation)
- [Reservation Management](#reservation-management)
- [Payment Services](#payment-services)
- [Payment Verification](#payment-verification)
- [Gift Cards](#gift-cards)
- [Room Types Management](#room-types-management)
- [Promo Codes](#promo-codes)
- [Contact & Communication](#contact--communication)
- [Admin Functions](#admin-functions)
- [Utility Endpoints](#utility-endpoints)

---

## Authentication & User Management

### Customer Registration & Login

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `POST` | `/registerCustomer` | Register a new customer | `form` (object), `cart` (array), `total` (number) |
| `POST` | `/signupMembers` | Register a new member | `data` (object) - member registration data |
| `POST` | `/loginMembers` | Login existing members | `data` (object) - login credentials |

---

## Room Management

### Room Availability & Filtering

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `GET` | `/filterRoom` | Filter and get available rooms | `checkin` (string), `checkout` (string), `location` (string) |
| `POST` | `/holdRoom` | Hold a room temporarily | Room booking data |
| `POST` | `/releaseRoom` | Release a held room | Room ID and booking data |
| `POST` | `/cleanupHolds` | Clean up expired room holds | None |

### Temporary Reservations

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `POST` | `/tempRes` | Create temporary reservation | `regesterObject` (object) - registration data |

---

## Price Calculation

### Location-Specific Price Endpoints

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `GET` | `/entotoPrice` | Get Entoto resort prices | None |
| `GET` | `/bishoftuPrice` | Get Bishoftu resort prices | None |
| `GET` | `/awashPrice` | Get Awash resort prices | None |
| `GET` | `/tanaPrice` | Get Lake Tana resort prices | None |

### Dynamic Price Calculation

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `POST` | `/calculatePrice` | Calculate room prices | `cart` (array) - booking items |
| `POST` | `/calculateBishoftu` | Calculate Bishoftu specific prices | Booking data |
| `POST` | `/calculateAwash` | Calculate Awash specific prices | Booking data |
| `POST` | `/calculateEntoto` | Calculate Entoto specific prices | Booking data |
| `POST` | `/calculateTana` | Calculate Lake Tana specific prices | Booking data |
| `POST` | `/calculateLoft` | Calculate loft room prices | Booking data |
| `POST` | `/calculatePre` | Calculate premium room prices | Booking data |
| `POST` | `/calculatePreEntoto` | Calculate Entoto premium prices | Booking data |
| `POST` | `/calculateAwashPrice` | Calculate Awash price details | Booking data |
| `POST` | `/calculateEntotoPrice` | Calculate Entoto price details | Booking data |
| `POST` | `/calculateTanaPrice` | Calculate Lake Tana price details | Booking data |

---

## Reservation Management

### Basic Reservation Operations

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `GET` | `/reservation/:confirmId` | Get reservation by confirmation ID | `confirmId` (string) - path parameter |
| `POST` | `/cancelReservation` | Cancel a reservation | Reservation cancellation data |
| `POST` | `/updateReservation` | Update payment status | Payment update data |


---

## Payment Services

### Payment Gateway Integration

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `POST` | `/chapa` | Initialize Chapa payment | Payment initialization data |
| `GET` | `/dashenSession` | Create Dashen Bank payment session | `amount` (number), `merchant` (string), `reservationId` (string) |
| `POST` | `/mastercardSession` | Create Mastercard payment session | Payment session data |

### Payment Pages

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `GET` | `/cybersource/:id` | Render Cybersource payment page | `id` (number) - path parameter |
| `GET` | `/mastercard/:session` | Render Mastercard payment page | `session` (string) - path parameter |

---

## Payment Verification

### Payment Confirmation

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `POST` | `/verifyChapaReservation` | Verify Chapa payment | `tx_ref` (string), payment verification data |
| `POST` | `/verifyDashinReservation` | Verify Dashen Bank payment | `transactionId` (string), `amount` (number) |
| `POST` | `/verifyMasterReservation` | Verify Mastercard payment | `sessionId` (string), `amount` (number) |
| `GET` | `/chapa/verify/:tx_ref` | Chapa payment verification callback | `tx_ref` (string) - path parameter |

---

## Gift Cards

### Gift Card Management

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `POST` | `/cards/getGiftCard` | Get available gift cards | Gift card query data |
| `POST` | `/cards/getGiftCardID` | Get gift card by ID | Gift card ID data |
| `POST` | `/cards/addGiftCard` | Add new gift card | Gift card creation data |
| `POST` | `/cards/orderGiftCard` | Order gift card | Gift card order data |
| `POST` | `/cards/payMPG5/startSoessin` | Start gift card payment session | Payment session data |

---

## Room Types Management

### Room Type CRUD Operations

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `GET` | `/roomTypes` | List all room types | Optional query parameters |
| `GET` | `/roomTypes/available` | Get available room types for dates | Date query parameters |
| `GET` | `/roomTypes/:typeId` | Get room type by ID | `typeId` (string) - path parameter |
| `POST` | `/roomTypes` | Create new room type | Room type creation data |
| `PUT` | `/roomTypes/:typeId` | Update room type | `typeId` (string), update data |
| `DELETE` | `/roomTypes/:typeId` | Delete room type | `typeId` (string) - path parameter |

---

## Promo Codes

### Promotional Code Management

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `POST` | `/getPromoCode` | Get and validate promo code | Promo code data |

---

## Contact & Communication

### Contact Form & Communication

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `POST` | `/contact` | Submit contact form | Contact form data |
| `GET` | `/emailtest` | Test email functionality | None |
| `GET` | `/textTest` | Test SMS functionality | None |

---

## Admin Functions

### Administrative Operations

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `GET` | `/dailyRes` | Get daily reservations (admin) | None |
| `GET` | `/admin/v1/generateQR/:loco` | Generate QR code for location | `loco` (string) - path parameter |
| `POST` | `/confirm/scanning` | Admit and redeem QR code | `qrCode` (string), `enteredCode` (string) |
| `GET` | `/confirm/:id` | Render QR code confirmation page | `id` (string) - path parameter |

---

## Utility Endpoints

### System Health & Documentation

| Method | Endpoint | Description | Parameters |
|--------|----------|-------------|------------|
| `GET` | `/` | API root - Hello World | None |
| `GET` | `/healthz` | Health check endpoint | None |
| `GET` | `/api-docs` | API documentation page | None |
| `GET` | `/test` | Testing endpoint | None |

---

## Response Status Codes

The API uses standard HTTP status codes:

- **200** - Success
- **201** - Created
- **400** - Bad Request
- **401** - Unauthorized
- **404** - Not Found
- **500** - Internal Server Error

## Authentication

Most endpoints do not require authentication. However, some admin endpoints may require special access.

## Rate Limiting

The API implements rate limiting to prevent abuse. Please respect reasonable request frequencies.

## CORS

The API supports CORS for the following origins:
- `https://kurifturesorts.com`
- `https://fe.kurifturesorts.com`
- `http://localhost:3000`
- `https://dwjr81ioc7y6h.cloudfront.net`

## Error Handling

All endpoints return consistent error responses in the following format:

```json
{
  "success": false,
  "error": {
    "type": "ErrorType",
    "message": "Error description"
  },
  "timestamp": "2024-01-01T00:00:00.000Z"
}
```

## Base URL

The API base URL depends on your environment:
- Development: `http://localhost:4000`
- Production: `https://your-production-domain.com`

---

*Last updated: January 2024*
*Version: 1.0* 