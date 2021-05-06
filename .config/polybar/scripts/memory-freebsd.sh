class Memory(AbstractMemory):
    """ FreeBSD implementation of AbstractMemory class """

    def _used(self):
        total = int(Sysctl.query("hw.realmem", default=0))
        pagesize = int(Sysctl.query("hw.pagesize", default=0))

        keys = [int(Sysctl.query(f"vm.stats.vm.v_{i}_count", default=0))
                for i in ["inactive", "free", "cache"]]

        used = total
        used -= sum(i * pagesize for i in keys)
        return used, "B"

    def _total(self):
        total = int(Sysctl.query("hw.realmem", default=0))
        return total, "B"





     34 class Memory(AbstractMemory):¬
   33     """ A Linux implementation of the AbstractMemory class """¬
   32 ¬
   31     def _used(self):¬
   30         mem_file = _mem_file()¬
   29         keys = [["MemTotal", "Shmem"],¬
   28                 ["MemFree", "Buffers", "Cached", "SReclaimable"]]¬
   27         used = sum(mem_file.get(i, 0) for i in keys[0])¬
   26         used -= sum(mem_file.get(i, 0) for i in keys[1])¬
   25         return used, "KiB"¬
   24 ¬
   23     def _total(self):¬
   22         return _mem_file().get("MemTotal", 0), "KiB"¬
