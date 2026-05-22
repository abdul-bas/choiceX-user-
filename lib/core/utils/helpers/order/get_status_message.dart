 String getStatusMessage(String status) {
    switch (status.toLowerCase()) {
      case 'order placed':
        return 'Placed';
      case 'order confirmed':
        return 'Confirmed';
      case 'processing':
        return 'Pending';
      case 'out for delivery':
        return 'Dispatch';
      case 'delivered':
        return 'Delivered';
      default:
        return 'Tracking';
    }
  }