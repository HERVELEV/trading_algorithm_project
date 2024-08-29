
# explainable_ai_models.py
import shap

def explain_model_predictions(model, data):
    # Use SHAP to explain predictions
    explainer = shap.TreeExplainer(model)
    shap_values = explainer.shap_values(data)
    return shap_values
