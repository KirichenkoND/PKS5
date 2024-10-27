package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
	"os"
	"strconv"
	"sync"

	"github.com/gorilla/mux"
)

// Product представляет продукт
type Product struct {
	ID          int     `json:"id"`
	ImageURL    string  `json:"image_url"`
	Name        string  `json:"name"`
	Description string  `json:"description"`
	Price       float64 `json:"price"`
}

var (
	products      []Product
	productsMutex sync.RWMutex
)

// Функция для загрузки продуктов из файла
func loadProducts() error {
	file, err := os.Open("products.json")
	if err != nil {
		if os.IsNotExist(err) {
			products = []Product{}
			return nil
		}
		return err
	}
	defer file.Close()

	data, err := ioutil.ReadAll(file)
	if err != nil {
		return err
	}

	return json.Unmarshal(data, &products)
}

// Функция для сохранения продуктов в файл
func saveProducts() error {
	data, err := json.MarshalIndent(products, "", "  ")
	if err != nil {
		return err
	}

	return ioutil.WriteFile("products.json", data, 0644)
}

// Получить все продукты
func getProductsHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	productsMutex.RLock()
	defer productsMutex.RUnlock()

	json.NewEncoder(w).Encode(products)
}

// Создать новый продукт
func createProductHandler(w http.ResponseWriter, r *http.Request) {
	var newProduct Product
	err := json.NewDecoder(r.Body).Decode(&newProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	productsMutex.Lock()
	defer productsMutex.Unlock()

	newProduct.ID = getNextProductID()
	products = append(products, newProduct)

	err = saveProducts()
	if err != nil {
		http.Error(w, "Failed to save products", http.StatusInternalServerError)
		return
	}

	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(newProduct)
}

// Получить продукт по ID
func getProductByIDHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	idStr := vars["id"]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	productsMutex.RLock()
	defer productsMutex.RUnlock()

	for _, product := range products {
		if product.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(product)
			return
		}
	}

	http.Error(w, "Product not found", http.StatusNotFound)
}

// Обновить продукт по ID
func updateProductHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	idStr := vars["id"]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	var updatedProduct Product
	err = json.NewDecoder(r.Body).Decode(&updatedProduct)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}

	productsMutex.Lock()
	defer productsMutex.Unlock()

	for i, product := range products {
		if product.ID == id {
			updatedProduct.ID = id
			products[i] = updatedProduct

			err = saveProducts()
			if err != nil {
				http.Error(w, "Failed to save products", http.StatusInternalServerError)
				return
			}

			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(updatedProduct)
			return
		}
	}

	http.Error(w, "Product not found", http.StatusNotFound)
}

// Удалить продукт по ID
func deleteProductHandler(w http.ResponseWriter, r *http.Request) {
	vars := mux.Vars(r)
	idStr := vars["id"]
	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Product ID", http.StatusBadRequest)
		return
	}

	productsMutex.Lock()
	defer productsMutex.Unlock()

	for i, product := range products {
		if product.ID == id {
			products = append(products[:i], products[i+1:]...)

			err = saveProducts()
			if err != nil {
				http.Error(w, "Failed to save products", http.StatusInternalServerError)
				return
			}

			w.WriteHeader(http.StatusNoContent)
			return
		}
	}

	http.Error(w, "Product not found", http.StatusNotFound)
}

// Получить следующий ID для продукта
func getNextProductID() int {
	maxID := 0
	for _, product := range products {
		if product.ID > maxID {
			maxID = product.ID
		}
	}
	return maxID + 1
}

func main() {
	err := loadProducts()
	if err != nil {
		fmt.Println("Error loading products:", err)
		return
	}

	r := mux.NewRouter()
	r.HandleFunc("/products", getProductsHandler).Methods("GET")
	r.HandleFunc("/products", createProductHandler).Methods("POST")
	r.HandleFunc("/products/{id:[0-9]+}", getProductByIDHandler).Methods("GET")
	r.HandleFunc("/products/{id:[0-9]+}", updateProductHandler).Methods("PUT")
	r.HandleFunc("/products/{id:[0-9]+}", deleteProductHandler).Methods("DELETE")

	fmt.Println("Server is running on port 8080!")
	http.ListenAndServe(":8080", r)
}
