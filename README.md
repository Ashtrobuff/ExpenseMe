# 💸ExpenseME
![Untitled design (1)](https://github.com/user-attachments/assets/4b460404-797d-49d3-9c30-3878751a1926)
ExpenseME is an iOS application built entirely using Swift and UIKit. It is designed to help users track and visualize their expenses effectively, with a focus on simplicity, performance, and dynamic interactivity. The app avoids reliance on external libraries and leverages native frameworks like CoreGraphics and CoreData.

---

## Features

### 1. 📈Visualizations Using CoreGraphics
- Provides detailed graphs of daily and monthly expenses.
- Visualizations are implemented using the CoreGraphics framework, ensuring smooth and customized rendering.

### 2. 🧾Ledger Management
- Dynamic ledgers allow users to update and delete expenses with intuitive swipe gestures.
- Offers a seamless way to manage transactions efficiently.

### 3. 📊Category Visualization
- Granular control over transaction categorization.
- Users can view expense breakdowns by category, helping them better understand spending habits.

### 4. 💽Data Persistence
- All data is stored and managed using CoreData.
- Data retrieval and queries are optimized using CoreData predicates.

### 5. 📱UIKit Exclusivity
- The app is implemented entirely with UIKit, ensuring a native and consistent iOS experience.
- No external libraries are used, focusing entirely on Apple’s native tools and frameworks.

---

## Upcoming Features

- **Export to .csv or PDF:** Allow users to export their ledgers for external use.
- **Payment Gateway Integration:** Add functionality to process payments within the app.
- **Cheque Splitter:** Simplify splitting shared expenses with a built-in tool.

---

## Challenges Faced

### 1. CoreData Integration
- Understanding and efficiently implementing CoreData for data persistence.
- Building an expense engine using CoreData predicates to query the database dynamically.

### 2. CoreGraphics Visualizations
- CoreGraphics, being a low-level API, required manual calculations for point coordinates, geometry paths, and clipping paths.
- Significant effort was put into making the graphs visually appealing and accurate.

---

## Technologies Used

- **CoreData:** For data storage and management.
- **CoreGraphics:** For creating custom visualizations and graphs.
- **CoreAnimation:** To enhance the visual appeal of graphs and transitions.
- **UIKit:** For building the app’s user interface.

---

## Installation Instructions

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/expenseME.git
   ```

2. Open the project in Xcode:
   ```bash
   cd expenseME
   open ExpenseME.xcodeproj
   ```

3. Select your desired simulator or device.

4. Build and run the project:
   - Press `Cmd + R` or click on the **Run** button in Xcode.

5. Enjoy tracking your expenses with ExpenseME!

---

## Contact
For questions, suggestions, or feedback, please feel free to open an issue.


![Untitled design (1)](https://github.com/user-attachments/assets/4b460404-797d-49d3-9c30-3878751a1926)

