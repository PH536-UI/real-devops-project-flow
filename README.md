# Terraform AWS Provisioner

## Arquitetura de Observabilidade
Esta infraestrutura suporta tanto desenvolvimento local (via Floci) quanto produção (AWS Real).

```mermaid
graph TD
    subgraph LOCAL_FLOCI
    Floci[Floci AWS Emulator] <--> TF1[Terraform Local]
    TF1 --> Prom[Prometheus] --> Graf[Grafana Local]
    end

    subgraph AWS_REAL
    AWS[AWS Resources] <--> TF2[Terraform Prod]
    TF2 --> CW[CloudWatch] --> Managed[AMP/AMG Managed] --> GrafCloud[Grafana Cloud]
    end
```

## Acesso aos Serviços (Local)
Após rodar o script de início, os serviços estarão disponíveis em:
- **Floci (AWS Mock):** http://localhost:4568
- **Grafana:** http://localhost:3002
- **Prometheus:** http://localhost:9092
