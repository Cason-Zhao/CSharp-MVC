using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Net.Mime.MediaTypeNames;

namespace EFDemo
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Test(TestQuery);
            Test(TestUpdate);
            Test(TestInsert);
            Test(TestInsertEntry);

            Console.WriteLine("Press Any Key To Exit!");
            Console.ReadKey(); 
        }

        static void Test(Action testAction)
        {
            Console.WriteLine();
            if (testAction == null)
            {
                Console.WriteLine("testAction 不可为Null!");
                Console.WriteLine();
            }
            Console.WriteLine("===========================");
            Console.WriteLine($"--->>>{string.Join("-", testAction.GetInvocationList().Select(p => p.Method.Name))}");
            testAction.Invoke();
        }

        static void TestQuery()
        {
            TestQuery(null);
        }

        static void TestQuery(System.Linq.Expressions.Expression<Func<Customers, bool>> predicate)
        {
            using (var ctx = new EFDemo.NorthwindEntities())
            {
                if (predicate == null)
                {
                    Console.WriteLine(JsonConvert.SerializeObject(ctx.Customers.First(), Formatting.Indented));
                }
                else
                {
                    var matchItem = ctx.Customers.Where(predicate).FirstOrDefault();
                    if (matchItem == null)
                    {
                        Console.WriteLine("当前条件下未查询到指定记录！");
                    }
                    else
                    {
                        Console.WriteLine(JsonConvert.SerializeObject(matchItem, Formatting.Indented));
                    }
                }
            }
        }

        static void TestInsert()
        {
            Customers insertedCustomer = null;
            using (var ctx = new EFDemo.NorthwindEntities())
            {
                var cloneCustomer = insertedCustomer = ctx.Customers.First().Clone<Customers>();
                cloneCustomer.CustomerID = "AAAAA";
                ctx.Customers.Add(cloneCustomer);
                ctx.SaveChanges();
            }

            TestQuery(p => p.CustomerID == insertedCustomer.CustomerID);
            Console.WriteLine("--->>>Restore");
            TestDelete(p => p.CustomerID == insertedCustomer.CustomerID);
            TestQuery(p => p.CustomerID == insertedCustomer.CustomerID);
        }

        static void TestUpdate()
        {
            using (var ctx = new EFDemo.NorthwindEntities())
            {
                var firstCustomer = ctx.Customers.First();
                firstCustomer.Address += "[Address]";
                ctx.SaveChanges();
            }

            TestQuery();

            using (var ctx = new EFDemo.NorthwindEntities())
            {
                var firstCustomer = ctx.Customers.First();
                firstCustomer.Address = firstCustomer.Address.Replace("[Address]", "");
                ctx.SaveChanges();
            }

            Console.WriteLine("--->>>Restore");
        }

        static void TestDelete(System.Linq.Expressions.Expression<Func<Customers, bool>> predicate)
        {
            using (var ctx = new EFDemo.NorthwindEntities())
            {
                var removedCustomer = ctx.Customers.Where(predicate).First();
                ctx.Customers.Remove(removedCustomer);
                ctx.SaveChanges();
            }

        }

        static void TestInsertEntry()
        {
            Customers insertedCustomer = null;
            using (var ctx = new EFDemo.NorthwindEntities())
            {
                var cloneCustomer = insertedCustomer = ctx.Customers.First().Clone<Customers>();
                cloneCustomer.CustomerID = "AAAAA";

                DbEntityEntry<Customers> dbEntityEntry = ctx.Entry<Customers>(cloneCustomer);
                dbEntityEntry.State = System.Data.Entity.EntityState.Added;
                ctx.SaveChanges();
            }

            TestQuery(p => p.CustomerID == insertedCustomer.CustomerID);
            Console.WriteLine("--->>>Restore");
            TestDelete(p => p.CustomerID == insertedCustomer.CustomerID);
            TestQuery(p => p.CustomerID == insertedCustomer.CustomerID);
        }
    }

    internal static class CommonExtension
    {
        public static T Clone<T>(this T source) where T: class, new()
        {
            var result = new T();
            foreach (var property in typeof(T).GetProperties())
            {
                property.SetValue(result, property.GetValue(source));
            }
            return result;
        } 
    }
}
