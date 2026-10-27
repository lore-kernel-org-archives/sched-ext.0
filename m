Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098214;
	b=WTzEWW+Upjo86DOxZfb612fKlF+P7gy2AMlfHFH1HmhTmcMoYC/Y7Ulvn76VmSbEx+MC
	 f+ujJ/pIk+YhGLfwfxhEgZfItpyPnFQWGb1a2oM1kCeDb1n6WBV3lN9JbwLLgFkpKUC1U
	 0J+z1PIrn4+AbqP8ld7RPznRw6E5ApYkMWA24UpoGSVqOtJTx4KSq9MiF+SfjG2zncj5/
	 oIILkYQEoCmkyM4D6a4fexJH/T/Yf6AO1/0mRGShUhbS8crym+8c2sDBQk88wdxvoe2TU
	 MX4Xz/qGSwQ/RuloPBMSxcwWZ6j2yMKX8aqEEqwikpIJYYR7dq5rvRlQMJnVZbkS0JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098214;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding;
	bh=Zm1ZMFHt+vDtsE6uhd9cmwQ/XuV6JbZYuMkcY3vwMXo=;
	b=or7j7aHYTz/OdiFmvC+7QT4iUBPFrG05dXP9N1Tgx8OAFKDqAFu4xgbnBvacRKWMLw8O
	 Cg5olW7RHSi40xpb5eKHj2JCyFZwo8kUmiNrDuB3Kv2TRcDwcsVAKIghRjYnFhfOy/v72
	 MqcYdwhyMY2LYfJa7udtbfGB8ld5qTQHcoPo94KQV3M+euxZsRl0vfcmxSJ+M9DTVtpJK
	 su6rfzF5IlaVIUdNgLIqJHZMsSOUMN+eY9wguQjAGk0F+1L8Ie2P+f1WJoEVHrIJES8KF
	 2ReNtJFKFENOUUE8QxEe8bzP29VNFUCAmWNQWbpsrYdRkEVkEhXTbliTrrOGPt9U50Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aqpzT9zB;
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66855606A31B;
	Tue, 27 Oct 2026 10:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66855606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aqpzT9zB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793098214; x=1824634214;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=fZ5z3CH2gHmgn+ZLPgqrXD36V11lVJFgcQBStrMHoGU=;
  b=aqpzT9zBYWMB2F/R5Rk6RT4szJtHl3aOzL/M01om5eETlYHxk0AlvUA5
   WSTEfA+CHk9aUnIDx42suNGRRm0bOBuhPc2RBnIuU4ghoSrsTrwwQLt9L
   YTFJP8tSKNOtbkwLNdzQRTi7CArkOzRl/oFHKt3isErNscwvI3jOO+jfC
   0p3a49JQi0iN7vpbcdudmVBNYRomDXhSA4LvXkNst0YswtWiUHpYMTS6K
   5jk2lXZaEhsCbOA6eZQynUr47ObkylM3RfNFXR3s2h/pj91ZWTvTI/c0H
   I2s2hqqvInFojJc/nsnZkXactphXiO2+cU73/fqCeepCFU5eBJ1fkfIKr
   Q==;
X-CSE-ConnectionGUID: sGi9dAr7TnuJZNAcZdMz0w==
X-CSE-MsgGUID: pPD6FTatRme3n/vF7dShlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1806851"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1806851"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:50:12 -0700
X-CSE-ConnectionGUID: CrPWIebURQa0uyex+Qyzjg==
X-CSE-MsgGUID: x8zZB4P/QK2/pjVnw9pBNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="6359406"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation) ([10.239.182.64])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:50:10 -0700
Date: Tue, 27 Oct 2026 18:50:06 +0800
From: kernel test robot <yi1.lai@intel.com>
To: Shubhang Kaushik <sh@gentwo.org>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Zhan Xusheng <zhanxusheng@xiaomi.com>, sched-ext@lists.linux.dev,
	aubrey.li@linux.intel.com, yu.c.chen@intel.com, yi1.lai@intel.com
Subject: [linus:master] [sched]  c72945693b:
 stress-ng.rawudp.packets_32_bytes_received_per_sec 34.2% improvement
Message-ID: <202610271134.d6bf1e10-lkp@intel.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit



Hello,

kernel test robot noticed a 34.2% improvement of stress-ng.rawudp.packets_32_bytes_received_per_sec on:


commit: c72945693b90423f1b46ac2dbc8749c2b7804fc8 ("sched: Restart fair hrtick after same-task repicks") https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

testcase: stress-ng
config: x86_64-rhel-9.4
compiler: gcc-14
test machine: 192 threads 2 sockets Intel(R) Xeon(R) 6740E  CPU @ 2.4GHz (Sierra Forest) with 256G memory
parameters:

	nr_threads: 100%
	testtime: 60s
	test: rawudp
	cpufreq_governor: performance


Details are as below:
-------------------------------------------------------------------------------------------------->


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20261027/202610271134.d6bf1e10-lkp@intel.com

=========================================================================================
compiler/cpufreq_governor/kconfig/nr_threads/rootfs/tbox_group/test/testcase/testtime:
  gcc-14/performance/x86_64-rhel-9.4/100%/debian-13-x86_64-20250902.cgz/lkp-srf-2sp3/rawudp/stress-ng/60s

commit: 
  a9b3c75705 ("sched/headers: Replace __ASSEMBLY__ with __ASSEMBLER__ in the <uapi/linux/sched.h> header")
  c72945693b ("sched: Restart fair hrtick after same-task repicks")

a9b3c7570564de40 c72945693b90423f1b46ac2dbc8
---------------- --------------------------- 
         %stddev     %change         %stddev
             \          |                \  
      0.01          +100.0%       0.02        stress-ng.rawudp.MB_recv'd_per_sec
   4559098           +34.1%    6112029 ±  3%  stress-ng.rawudp.ops
     76041           +34.0%     101916 ±  3%  stress-ng.rawudp.ops_per_sec
    395.33           +34.2%     530.63 ±  3%  stress-ng.rawudp.packets_32_bytes_received_per_sec
   2611008 ±  2%     +14.9%    2999104 ±  5%  stress-ng.time.involuntary_context_switches
     47.70 ±  7%     +46.7%      69.96 ±  8%  stress-ng.time.user_time
  20919233 ±  4%     +41.7%   29638128 ±  2%  stress-ng.time.voluntary_context_switches


Disclaimer:
Results have been estimated based on internal Intel analysis and are provided
for informational purposes only. Any difference in system hardware or software
design or configuration may affect actual performance.


-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


