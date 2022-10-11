using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Demo02_ModelFirst
{
    internal class Program
    {
        static void Main(string[] args)
        {
            using(Model1stModelContainer container = new Model1stModelContainer())
            {
                Student student = new Student()
                {
                    Name="张三",
                    Age= 18,
                };

                Book book = new Book()
                {
                    Id = Guid.NewGuid(),
                    BookName = "高一化学",
                    Price = 20,
                };

                Book book2 = new Book()
                {
                    Id = Guid.NewGuid(),
                    BookName = "高一物理",
                    Price = 30,
                };

                StudentBookOrder studentBookOrder = new StudentBookOrder()
                {
                    Id=Guid.NewGuid(),
                    Student=student,
                    Book= new List<Book>() { book },
                    Amount = book.Price,

                    CreatedDate = DateTime.Now
                };

                StudentBookOrder studentBookOrder2 = new StudentBookOrder()
                {
                    Id=Guid.NewGuid(),
                    StudentNo = student.No,
                    Book= new List<Book>() { book, book2 },

                    Amount = book.Price + book2.Price,

                    CreatedDate = DateTime.Now
                };

                container.StudentSet.Add(student);
                container.BookSet.Add(book);
                container.BookSet.Add(book2);
                container.StudentBookOrderSet.Add(studentBookOrder);
                container.StudentBookOrderSet.Add(studentBookOrder2);

                if(container.SaveChanges() > 0)
                {
                    Console.WriteLine("Save Success!");
                }
                else
                {
                    Console.WriteLine("Save Fail!");
                }
            }
        }
    }
}
