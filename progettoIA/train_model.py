import joblib
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import classification_report, accuracy_score

# Carica feature
X, y, le = joblib.load("features.pkl")

# Split train / test
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

# Classificatore k-NN (ricerca locale)
knn = KNeighborsClassifier(
    n_neighbors=5,
    metric="euclidean"
)

# Training
knn.fit(X_train, y_train)

# Test
y_pred = knn.predict(X_test)

print("Accuracy:", accuracy_score(y_test, y_pred))
print(classification_report(y_test, y_pred, target_names=le.classes_))

# Salva modello
joblib.dump((knn, le), "model.pkl")

print("Modello addestrato e salvato!")
