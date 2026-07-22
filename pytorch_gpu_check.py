import torch
x = torch.rand(5, 3)
print(x)

print("CUDA Available:", torch.cuda.is_available())