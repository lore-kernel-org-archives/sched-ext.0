Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405FE311C11;
	Thu, 26 Mar 2026 06:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774507405; cv=none; b=RJtqrOcCvVIl8lXASCyC26z0kWGXNlbI9SdXyNQGxkcNVbRYMwQTsFIudgbMwN95gzOiNjxJWEqNy0q02ekDuTm3/tSWgjcfY4/cxjqrJfx1mbKpQY2h/MUSEt36UBDxyc1hrRNLSlx3jKE1dKCf+KBHoDEyH1PV+8pgh1+uE3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774507405; c=relaxed/simple;
	bh=qSexQmpuDMmwpl+CIU7fbjXqVQSQ5xSuV7IQEg37s8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSuEtB4//0OnEJYbV8OWN74EKabuYfapsTcgdPDzdufeO0HDmtUL/MFGv7uVJwjwNYh7AY0lTtOo1YsNyJiDTmXY4nmlmtE0/dTSdRHFKxRbH0unjuhIdIkrSMy3cFt8nc6k9QPEqXGSGIF1QgIcYgj6OlTLiT47sYjsxQgPDms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvLwEDV+; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvLwEDV+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774507403; x=1806043403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qSexQmpuDMmwpl+CIU7fbjXqVQSQ5xSuV7IQEg37s8Y=;
  b=kvLwEDV+ojM2nLJ9WScdfsqidiriDJ0sDkyQWGK8Kgb2DPR9FPW3mi+Y
   VM3pFKrQDiI9fMSc3GJ/uuMaCYJv8XIPQ8AS1RFbPYysserWxFm78K0C5
   PZs0u9haImCVj4K88qLkKcmmQrj+WCg9AtHJeJXKk3/crGnpfUN6vLrMI
   1R7VYE1dk5jE6AUCuBaTvqn0BtPgdB/jcI8CZvFacKjlXTaXxX205UxN3
   9Uek+jE0qtU2PUukuLf3adW1oy2njok/llqQIbPrOoQ2G+Q1UJ//vnaW6
   XoOA79T9bLJejGjPwfN9I/+Cx+GCkgHWXkzxRmF3ZgaAG6KL2Xv5EUTwb
   g==;
X-CSE-ConnectionGUID: ROaYYkM3SriOmqGbCYMegg==
X-CSE-MsgGUID: H6JodjWTQZSqzmhWNqhPGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="79462652"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="79462652"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 23:43:23 -0700
X-CSE-ConnectionGUID: wBL8JgPuRSmtr5GEUguCvg==
X-CSE-MsgGUID: 4MPjA0KCTKGw4me0t0fWPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="255404103"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Mar 2026 23:43:20 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5eR2-000000008ML-44oD;
	Thu, 26 Mar 2026 06:43:16 +0000
Date: Thu, 26 Mar 2026 14:42:55 +0800
From: kernel test robot <lkp@intel.com>
To: Zqiang <qiang.zhang@linux.dev>, tj@kernel.org, void@manifault.com,
	arighi@nvidia.com, changwoo@igalia.com
Cc: oe-kbuild-all@lists.linux.dev, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, qiang.zhang@linux.dev
Subject: Re: [PATCH] sched_ext: Choose the right sch->ops.name to output in
 the print_scx_info()
Message-ID: <202603261453.8kiJImYo-lkp@intel.com>
References: <20260324120313.12632-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324120313.12632-1-qiang.zhang@linux.dev>

Hi Zqiang,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on linus/master v7.0-rc5]
[cannot apply to next-20260325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Zqiang/sched_ext-Choose-the-right-sch-ops-name-to-output-in-the-print_scx_info/20260326-043528
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20260324120313.12632-1-qiang.zhang%40linux.dev
patch subject: [PATCH] sched_ext: Choose the right sch->ops.name to output in the print_scx_info()
config: x86_64-rhel-9.4-bpf (https://download.01.org/0day-ci/archive/20260326/202603261453.8kiJImYo-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261453.8kiJImYo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261453.8kiJImYo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_policy.c:62:
   kernel/sched/ext.c: In function 'scx_vexit':
   kernel/sched/ext.c:4800:9: warning: function 'scx_vexit' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
    4800 |         vscnprintf(ei->msg, SCX_EXIT_MSG_LEN, fmt, args);
         |         ^~~~~~~~~~
   kernel/sched/ext.c: In function 'print_scx_info':
>> kernel/sched/ext.c:5719:15: error: implicit declaration of function 'scx_task_sched_rcu' [-Wimplicit-function-declaration]
    5719 |         sch = scx_task_sched_rcu(p);
         |               ^~~~~~~~~~~~~~~~~~
>> kernel/sched/ext.c:5719:13: error: assignment to 'struct scx_sched *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    5719 |         sch = scx_task_sched_rcu(p);
         |             ^


vim +/scx_task_sched_rcu +5719 kernel/sched/ext.c

  5695	
  5696	/**
  5697	 * print_scx_info - print out sched_ext scheduler state
  5698	 * @log_lvl: the log level to use when printing
  5699	 * @p: target task
  5700	 *
  5701	 * If a sched_ext scheduler is enabled, print the name and state of the
  5702	 * scheduler. If @p is on sched_ext, print further information about the task.
  5703	 *
  5704	 * This function can be safely called on any task as long as the task_struct
  5705	 * itself is accessible. While safe, this function isn't synchronized and may
  5706	 * print out mixups or garbages of limited length.
  5707	 */
  5708	void print_scx_info(const char *log_lvl, struct task_struct *p)
  5709	{
  5710		struct scx_sched *sch;
  5711		enum scx_enable_state state = scx_enable_state();
  5712		const char *all = READ_ONCE(scx_switching_all) ? "+all" : "";
  5713		char runnable_at_buf[22] = "?";
  5714		struct sched_class *class;
  5715		unsigned long runnable_at;
  5716	
  5717		guard(rcu)();
  5718	
> 5719		sch = scx_task_sched_rcu(p);
  5720	
  5721		if (!sch || state == SCX_DISABLED)
  5722			return;
  5723	
  5724		/*
  5725		 * Carefully check if the task was running on sched_ext, and then
  5726		 * carefully copy the time it's been runnable, and its state.
  5727		 */
  5728		if (copy_from_kernel_nofault(&class, &p->sched_class, sizeof(class)) ||
  5729		    class != &ext_sched_class) {
  5730			printk("%sSched_ext: %s (%s%s)", log_lvl, sch->ops.name,
  5731			       scx_enable_state_str[state], all);
  5732			return;
  5733		}
  5734	
  5735		if (!copy_from_kernel_nofault(&runnable_at, &p->scx.runnable_at,
  5736					      sizeof(runnable_at)))
  5737			scnprintf(runnable_at_buf, sizeof(runnable_at_buf), "%+ldms",
  5738				  jiffies_delta_msecs(runnable_at, jiffies));
  5739	
  5740		/* print everything onto one line to conserve console space */
  5741		printk("%sSched_ext: %s (%s%s), task: runnable_at=%s",
  5742		       log_lvl, sch->ops.name, scx_enable_state_str[state], all,
  5743		       runnable_at_buf);
  5744	}
  5745	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
