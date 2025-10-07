Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B0216E1B
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840832; cv=none; b=YCoXvIY4N86J/uuERgg4pANJHTIsP2DfwLaaW7OE0/aACnu/DV2/ij9q74G03zOvW558C+s0tKHmSN+A7g8mvCgT9eR9rBI2S2ccwjqJJMG4Yws3fIGzAsrYlUggG0hivyrLqPF+oe8RVKPqbYOwPIU0b+f1oV7K4RZf48dFQ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840832; c=relaxed/simple;
	bh=f641r4J2AyZRWitszS0fbzxMAdMnCERCq43FF5E1Oac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fA4pZnkxaz032xGyTpFJ32Lj+LjcIPEt8KDnn9z+cklWENDplqvh1fABTq7dHHkbmJ3SrllXSMB8jBXyLkOh2Q7KSrOxqunt3+p/EdQXxavv2CjkbMnboLzcLNKf+WokYUs2UwQinSJLEzTxBeMkHRIkVM9nwKPWPG4/5ItlNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EADBC1424;
	Tue,  7 Oct 2025 05:40:20 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D78773F738;
	Tue,  7 Oct 2025 05:40:24 -0700 (PDT)
Message-ID: <7d13109d-28e6-46fa-898c-388fc9912710@arm.com>
Date: Tue, 7 Oct 2025 13:40:22 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH 0/3] sched/ext: Cleanup pick_task_scx()
To: Peter Zijlstra <peterz@infradead.org>, tj@kernel.org
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 longman@redhat.com, hannes@cmpxchg.org, mkoutny@suse.com,
 void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 cgroups@vger.kernel.org, sched-ext@lists.linux.dev, liuwenfang@honor.com,
 tglx@linutronix.de
References: <20251006104652.630431579@infradead.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20251006104652.630431579@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/6/25 11:46, Peter Zijlstra wrote:
> Hi,
> 
> So I had a poke at 'give @rf to pick_task() and fold balance_scx() into
> pick_task_scx()' option to see how terrible it was. Turns out, not terrible at
> all.
> 
> I've ran the sched_ext selftest and stress-ng --race-sched 0 thing with various
> scx_* thingies on.
> 
> These patches were done on top of the 'sched_change' patches posted just now:
> 
>   https://lkml.kernel.org/r/20251006104402.946760805@infradead.org
> 
> The combined set is also available here:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup-pick
> 

FWIW I didn't run into any issues either running some scx scheduler + workload
combinations.
