#include <iostream>
using namespace std;

int main() {
    cout << "Hello, C++ RAAJK20Pro GitHub!" << endl;
    return 0;
}


/**
 * @file main.cpp
 * @brief A modern C++ demonstration with clean code, error handling, and documentation
 * @author RAAJK20Pro
 * @date 2023
 * @license MIT
 */

#include <iostream>
#include <vector>
#include <stdexcept>
#include <string_view>

// ===== CONSTANTS =====
constexpr int MAX_ATTEMPTS = 3; ///< Max retries for user input

// ===== CUSTOM EXCEPTION =====
class AppError : public std::runtime_error {
public:
    explicit AppError(const std::string& msg) : std::runtime_error(msg) {}
};

// ===== CORE FUNCTIONALITY =====

/**
 * @brief Calculates factorial (constexpr for compile-time evaluation)
 * @param n Input number (must be >= 0)
 * @return Factorial of n
 * @throws AppError if input is negative
 */
constexpr unsigned long long factorial(int n) {
    if (n < 0) throw AppError("Negative input not allowed");
    return (n <= 1) ? 1 : n * factorial(n - 1);
}

/**
 * @brief Demonstrates modern C++ features
 */
void demonstrateFeatures() {
    // ---- Modern C++20 Features ----
    std::cout << "\n=== C++20 Features ===\n";
    
    // 1. std::string_view (no copy)
    std::string_view message = "Hello Modern C++";
    std::cout << message << "\n";

    // 2. Structured bindings (C++17)
    auto [min, max] = std::pair(1, 100);
    std::cout << "Range: " << min << "-" << max << "\n";

    // 3. Ranges (C++20)
    std::vector<int> nums{1, 2, 3, 4, 5};
    std::cout << "Numbers: ";
    for (int num : nums | std::views::filter([](int x){ return x % 2 == 0; })) {
        std::cout << num << " ";
    }
    std::cout << "\n";
}

// ===== MAIN PROGRAM =====
int main() {
    try {
        std::cout << "=== C++ Best Practices Demo ===\n";

        // ---- User Input with Validation ----
        int number;
        for (int attempt = 0; attempt < MAX_ATTEMPTS; ++attempt) {
            std::cout << "Enter a positive integer (0-20): ";
            if (!(std::cin >> number) || number < 0 || number > 20) {
                std::cin.clear();
                std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
                std::cerr << "Invalid input. Attempts left: " 
                          << MAX_ATTEMPTS - attempt - 1 << "\n";
                continue;
            }
            break;
        }

        if (number < 0 || number > 20) {
            throw AppError("Maximum attempts exceeded");
        }

        // ---- Core Logic ----
        std::cout << number << "! = " << factorial(number) << "\n";
        demonstrateFeatures();

        return EXIT_SUCCESS;
    } 
    catch (const AppError& e) {
        std::cerr << "[ERROR] " << e.what() << "\n";
        return EXIT_FAILURE;
    }
    catch (...) {
        std::cerr << "[ERROR] Unknown exception occurred\n";
        return EXIT_FAILURE;
    }
}
