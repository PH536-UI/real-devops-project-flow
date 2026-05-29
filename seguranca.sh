#!/bin/bash

# Script de Check-in de Segurança
echo "--- Iniciando Scan de Segurança ---"

# Ativa o ambiente virtual, se existir
if [ -d ".venv" ]; then
    source .venv/bin/activate
fi

# Roda o Checkov e salva o resultado num ficheiro de log
checkov -d . --framework terraform dockerfile > scan_results.txt

echo "Scan concluído! Resultados salvos em scan_results.txt"
echo "--- Verifique sua checklist em checklist_seguranca_aws.md ---"
