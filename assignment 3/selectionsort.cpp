#include <iostream>

// Action: swap elements v[i] and v[j]
void swap (int v[], int i, int j)
{
    int tmp;
    std::cout << i << " " << j << std::endl;
    tmp	= v[i];
    v[i]	= v[j];
    v[j]	= tmp;
}


// Result: index of the smallest element in the array
// v[first], v[first+1], ... , v[last]
int indexMinimum (int v[], int first, int last)
{
    int i, min, mini;

    mini	= first;
    min	= v[first];

    for (i = first + 1; i <= last; i++)
    {
        if (v[i] < min)
        {
            mini	= i;
            min	= v[i];
        }
    }

    return mini;
}


// Action: sort table a[]
void selectionSort (int a[], int length)
{
    int i, mini;

    for (i = 0; i < length - 1; i++)
    {
        mini = indexMinimum (a, i, length - 1);
        swap (a, i, mini);
    }
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

    selectionSort (a, length);

    std::cout << "The sorted array is:" << std::endl;
    for (i = 0; i < length; i++)
    {
        std::cout << a[i] << std::endl;
    }

    return 0;
}