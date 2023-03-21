#include <iostream>

// Action: insert element elem in array a at positions i
void insert (int a[], int length, int elem, int i)
{
    int j;
    for (j = length - 1; j >= i; j--)
    {
        a[j+1] = a[j];
    }
    a[i] = elem;
}


// Result: smallest i for which holds: a[i] >= elem
int binarySearch (int a[], int length, int elem)
{
    int low=-1, high = length, mid;

    while (low < high - 1)
    {
        mid = (low + high) / 2;

        if (a[mid] >= elem)
            high = mid;
        else if (a[mid] < elem)
            low = mid;
    }

    return high;
}


// Action: sort table using the Insertion Sort Algorithm
void insertionSort (int a[], int length)
{
    int i;
    int *b = new int [length];

    for (i = 0; i < length; i++)
    {
        int position = binarySearch (b, i, a[i]);
        insert (b, i, a[i], position);
    }

    for (i = 0; i < length; i++)
    {
        a[i] = b[i];
    }

    delete [] b;
}


int main (void)
{
    int i, length;
    int *a;

    std::cout << "Insert the array size" << std::endl;
    std::cin >> length;

    a = new int[length];

    std::cout << "Insert the array elements, one per line" << std::endl;
    for (i = 0; i < length; i++)
    {
        std::cin >> a[i];
    }

    insertionSort (a, length);

    std::cout << "The sorted array is:" << std::endl;
    for (i = 0; i < length; i++)
    {
        std::cout << a[i] << std::endl;
    }

    return 0;
}