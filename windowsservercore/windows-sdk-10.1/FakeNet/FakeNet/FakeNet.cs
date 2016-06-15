namespace FakeNet
{
    using System;
    using System.Diagnostics;

    class FakeNet
    {
        static void Main(string[] args)
        {
            if (args.Length == 0)
                return;

            if (args[0].Trim() == "session")
            {
                Console.WriteLine("There are no entries in the list.\n");
                return;
            }

            //ProcessStartInfo startInfo = new ProcessStartInfo(@"c:\windows\system32\net.exe");
            //startInfo.Arguments = string.Join(" ", args);
            //startInfo.UseShellExecute = false;
            //Process.Start(startInfo);
        }
    }
}
