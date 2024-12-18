#include <stdio.h>
#include <string.h>

int main() {
    char src[] = "Hello, World!";
    char dest[20];  // Ensure dest has enough space for the copied string

    // Copy the first 5 characters from src to dest
    strncpy(dest, src, 5);
    dest[5] = '\0';  // Manually add null-terminator

    printf("Source: %s\n", src);
    printf("Destination (first 5 characters): %s\n", dest);

    // Copy 15 characters (more than src length)
    strncpy(dest, src, 15);
    dest[15] = '\0';  // Manually add null-terminator

    printf("Destination (first 15 characters): %s\n", dest);

    return 0;
}
