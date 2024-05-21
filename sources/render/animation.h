#pragma once

struct OptimizationSettings
{
  float tolerance = 1.0f; // mm
  float distance = 100.0f; // mm
};

struct OptimizationStats
{
  size_t rawSize = 0;
  size_t compressedRawSize = 0;
  size_t runtimeSize = 0;
};