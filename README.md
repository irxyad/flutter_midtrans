# 🚀 Flutter Midtrans

**📱 Android Tested Only**

> **⚠️ Important Note**: This project requires a backend server to obtain Token from Midtrans API. Tokens cannot be created directly from mobile applications for security reasons.

Flutter project for Midtrans payment integration using **midtrans-sdk** or **Webview Snap Midtrans**.

## 📋 Documentation & References

- **Flutter Midtrans Package**: [pub.dev/packages/midtrans_sdk](https://pub.dev/packages/midtrans_sdk)
- **Snap Preference Customization**: [dashboard.sandbox.midtrans.com/settings/snap_preference](https://dashboard.sandbox.midtrans.com/settings/snap_preference)

## ⚙️ Installation & Configuration

### 1. Setup Environment Variables

Create a `.env` file in your project root and add the following configuration:

```env
MIDTRANS_CLIENT_KEY=your_client_key_here
MIDTRANS_MERCHANT_BASE_URL=your_merchant_base_url_here
BASE_URL=your_backend_server_url_here
```

**How to get configuration:**

- **MIDTRANS_CLIENT_KEY**: Get from [Access Keys Settings](https://dashboard.sandbox.midtrans.com/settings/access-keys)
- **MIDTRANS_MERCHANT_BASE_URL**: Get from **Merchant URL** section in [General Info Settings](https://dashboard.sandbox.midtrans.com/settings/general_info)
- **BASE_URL**: Your backend server URL

### 2. Dependencies

```yaml
dependencies:
  midtrans_sdk: ^latest_version # if you don't want to use Webview
  webview_flutter: ^latest_version # for Webview Snap Midtrans
  http: ^latest_version # to get Token from backend server
  dartz: ^latest_version # for response handling
  flutter_dotenv: ^latest_version # to read .env file
```

## 🧪 Testing & Development

### Email Notifications

1. **Enable Email Notifications:**

   - Open [Email Notifications Settings](https://dashboard.sandbox.midtrans.com/settings/email_notifications)
   - Check the **"Send email to customer"** option

2. **Fake Email for Testing:**
   - Use [inboxes.com](https://inboxes.com/) to get temporary email
   - This email will receive invoices and payment notifications

### Payment Simulator

For testing payments without real transactions:

1. Select payment method in Flutter application
2. Copy the generated transaction code
3. Open [Midtrans Payment Simulator](https://simulator.sandbox.midtrans.com/)
4. Paste the transaction code and simulate payment

## 🔧 Customization

### Snap Preference Customization (if use Webview)

Customize Snap payment appearance and behavior through:
[Snap Preference Settings](https://dashboard.sandbox.midtrans.com/settings/snap_preference)

**Available Options:**

- Theme customization
- Payment methods selection
- Language settings
- Redirect URLs configuration

## 🛠️ Additional Notes

**Testing Environment**: Always use sandbox environment for development

---

**Happy Coding! 🎉**
