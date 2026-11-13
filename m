Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547919;
	b=zXd3D/noBNPD5JtuUpeNJYJ4MNvDhX6CDlz/hZWu1VHSBXUTvhfRzeQ42zxjoMMyWqOU
	 fvvMF0Re/nJLErV7kYJMKv8Tjblz6uSR9c3xNP6g+Aj2Egp+8eAN0Yy05jmh/mmRs5sp+
	 H1T9OgtLfKA6xdHG19fh9oR3GyhiU/OxZV1TnS20Bp6qC+m7KzcwOa65KEGYF1xT3/yjD
	 ZJ4jlaU+6pCfFGJkyV4z5CR39kqrwJgnDtAJtIODbqsyRn+Bg8nh+Q72zn7L8P3i0vjMK
	 wKtTIeKnJzb6VAI7lJSA4daJjN4s7TDwzBTNZh0awqsjm5UmdCr13VprOu7C7ar9SEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547919;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Ba6WMI+eH0A0XYWzYjkOrHuY+1qhzJ7ZLbDOBJrgo58=;
	b=q31obQPi2Y9qHmltnDgIYEpQ0jIdh3bAXmYF/I3B+6z/FZ8Kz7pUX2KaK+0imDPBaGSc
	 Tz8bDW0wutb78/HbNaOUGJGBst3ICbcHcAjhb/pmPbYZjDiZKQDHoOM04rszmRp7hmJ3P
	 sVhX4JOpAjGhjuftiENAzJ+D9d3W7BF5JRUT2BfdStUAB55VcLCXwkZ7u+uJjXZWYPiXQ
	 hTx6ZWc0qLBVk+Ee74xDPvpkyIo9q4iS9309MtarNh0674Xq7GGuekTS/PfQEfqUX/HPe
	 Z6sCtSHGlNZLxLbekTKm6z3FBsEMyLSLR4WcstbQ8Em6klOaASQ12zxky1ITb2LkWCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="FE6P8j/0";
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105E1606A31C;
	Fri, 13 Nov 2026 05:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 105E1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=FE6P8j/0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794547917; x=1826083917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wU1MQ3okr3j4hH5DB7t1ThuMNxBMz1z5jxvll2cwO8E=;
  b=FE6P8j/0c+Np920CAIEf+t4AB5Mv/fr/koSl6q2XDdU6SA8gVXOHrskK
   7SPKP2fiADk5QNqqeidk9cKY/pr35Zls3Fx/rVYIYMLXbsr8V4YpyI6JX
   H38IVJ/pcbRI17ucjZfRP3/kXq2VqTQqanR98fEPkn5bSNNVfmDSZkd/e
   M3zzNf7ddGhwgdRCiVw9VJSQiNz4w1ydoAiJXy6/8ycUxFKTUw3OlzhkV
   jlcF3aNZF3oMUDRxTIcJ8uYgV/HegQPPrk3Gmpn2K1/jSP1OCMJb/N3fo
   4nxGZa02HMoapubK3Fh+k765UnGRQ6eSqWNflC42+ZyxtTtG9DNiWF+QA
   g==;
X-CSE-ConnectionGUID: B9k9MuzhQQCHucogspBzYg==
X-CSE-MsgGUID: Ijs8+SU8QUm+YezgRfX5Rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3333636"
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="3333636"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 21:31:57 -0800
X-CSE-ConnectionGUID: PJtJPZlQTpK0EHcF36dOgQ==
X-CSE-MsgGUID: 6NTBylRbQt+nZaN19ITuWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,211,1787036400"; 
   d="scan'208";a="9179999"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 12 Nov 2026 21:31:52 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xRjt6-000000012QV-1CP8;
	Fri, 13 Nov 2026 05:31:48 +0000
Date: Fri, 13 Nov 2026 13:31:22 +0800
From: kernel test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
	peterz@infradead.org, juri.lelli@redhat.com,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org, lukasz.luba@arm.com,
	rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: oe-kbuild-all@lists.linux.dev, qyousef@layalina.io,
	christian.loehle@arm.com, pierre.gondois@arm.com,
	sshegde@linux.ibm.com, kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 12/20 v3] sched/fair: Support not wakeup case in
 select_idle_sibling
Message-ID: <202611131321.iXTrhEmV-lkp@intel.com>
References: <20261106151947.3991524-13-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-13-vincent.guittot@linaro.org>

Hi Vincent,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[cannot apply to peterz-queue/sched/core amd-pstate/linux-next amd-pstate/bleeding-edge linus/master v7.4-rc2 next-20261111]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vincent-Guittot/sched-eevdf-Reset-lag-at-wakeup-when-prev-CPU-has-been-idle/20261106-161929
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20261106151947.3991524-13-vincent.guittot%40linaro.org
patch subject: [PATCH 12/20 v3] sched/fair: Support not wakeup case in select_idle_sibling
config: nios2-allnoconfig (https://download.01.org/0day-ci/archive/20261113/202611131321.iXTrhEmV-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261113/202611131321.iXTrhEmV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611131321.iXTrhEmV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: kernel/sched/fair.c:12994 function parameter 'rq' not described in 'idle_rq_without'
>> Warning: kernel/sched/fair.c:12994 Excess function parameter 'cpu' description in 'idle_rq_without'
>> Warning: kernel/sched/fair.c:12994 function parameter 'rq' not described in 'idle_rq_without'
>> Warning: kernel/sched/fair.c:12994 Excess function parameter 'cpu' description in 'idle_rq_without'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
