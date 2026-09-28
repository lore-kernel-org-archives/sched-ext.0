Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8D4DEC1D;
	Mon, 28 Sep 2026 15:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609951; cv=none; b=NPQ6d+Lf3icEOxRBdSaLfcfqrhR+LHGhAudbYWQHxCWBlX/CraA96MbX/1XfESL9AiYTHssX4YjfmaVJXuAFmNIKja0LkbLhn9v6raY9/FaLy6XZLar98oflhId38g0P55YyZxnC2J+hsdrlVB1Af6sRz21tCM/uz1ZTApQVizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609951; c=relaxed/simple;
	bh=mI6GA1s/6zctdIbELhsFif0NG9b6bMAvxtY3uqPSZ3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JdFanY6D53l0SL7gB2CSNZHZh313s8g2nP2pR1M8v2vws7UFX2K/F0uM6LuvQfPa0B5/4d5zoUd6yKQ7d2L+ovvAXO8rBaX9+o7jE0ABa14MOy6TJyOUaoyKFqdFWLbR3VVafgKebsCiIsJAegtsudPwbpZwbbWtPoqRFDJ8P6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ftUFyFow; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ftUFyFow"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 465441655;
	Mon, 28 Sep 2026 08:39:05 -0700 (PDT)
Received: from [10.57.52.74] (unknown [10.57.52.74])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2D403F763;
	Mon, 28 Sep 2026 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790609948; bh=mI6GA1s/6zctdIbELhsFif0NG9b6bMAvxtY3uqPSZ3I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ftUFyFowGNkXBc87rLTpLZFpaO41UpzF83wuOXuJrXaIqrjTRD+koTVspLCtsBpAP
	 lCqvyjc6w/9Z0ICfq4F+1W5YJ5VFVbwKeqSgwW0/InO9jOT5GIkTQ+p4o/334a1xNo
	 1TV0JjwZkiUaX876R2r4JGZc8ioeXOewTrsWT+BE=
Message-ID: <cf2e4daa-c00c-4c7f-a9d2-ce0d7ed380e8@arm.com>
Date: Mon, 28 Sep 2026 16:39:04 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move
 SCHED_EXT above SCHED_RR/SCHED_FIFO
To: Tengfei Fan <tengfei.fan@oss.qualcomm.com>, Tejun Heo <tj@kernel.org>,
 Fredrik Boettger Bratberg <fredrik.b.bratberg@gmail.com>
Cc: Henrik Austad <henrik@austad.us>, Peter Ziljstra <peterz@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>,
 linux-rt-devel@lists.linux.dev, sched-ext@lists.linux.dev,
 aiqun.yu@oss.qualcomm.com
References: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com>
 <ad539mUd8A0lDWAw@slm.duckdns.org>
 <f8e91551-64d8-4cad-9757-f461fb13fb7c@oss.qualcomm.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <f8e91551-64d8-4cad-9757-f461fb13fb7c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/21/26 08:47, Tengfei Fan wrote:
> 
> On 4/15/2026 1:23 AM, Tejun Heo wrote:
>> Hello,
>>
>> On Tue, Apr 14, 2026 at 02:59:33PM +0200, Fredrik Boettger Bratberg wrote:
>>> A recent paper published in the 2025 Real-Time Systems Symposium (RTSS)
>>> "Enabling Flexible Scheduling in ROS 2", would presumably also benefint
>>> from this feature. The paper aims to address and improve the real-time
>>> capabilities of Robot Operating System 2 (ROS2). As part of their paper
>>> they implement an EDF using sched_ext. They do not explicitly address the
>>> issue of their EDF SCHED_EXT tasks effectively having a lower priority than
>>> SCHED_NORMAL, but it is a known limitation of the current sched_ext class
>>> placement
>> Isn't that mostly solvable by just not putting tasks in DL/RT and enabling
>> switching_all?
> 
> Sched_ext is an enhancement mechanism rather than a replacement for RT scheduling. RT scheduling continues to provide the latency guarantees, safety properties, and forward-progress guarantees required by the system. Additionally, the system must remain fully functional if sched_ext exits and falls back to the in-kernel scheduler. As a result, in real-world systems, assuming that RT workloads can simply be eliminated is often not practical.
>>
>>> This change conditionally reorders sched_class selection such that, when
>>> enabled:
>>>
>>>    STOP > DL > EXT > RT > FAIR > IDLE
>> The problem is that RT being above EXT is required for safety as EXT depends
>> on RT superceding it for enable/disable path forward progress guarantee. If
>> you put EXT on top of RT, it's relatively easy to stall out the whole system
>> without any way to recover it.
> 
> Rather than requiring all RT tasks to be isolated from sched_ext, it may
> be beneficial to distinguish between recovery-critical RT tasks and
> non-critical RT tasks. Recovery-critical RT tasks would remain outside
> sched_ext control to guarantee safety and recoverability, while
> non-critical RT tasks could optionally be handed over to sched_ext.
> 
> This would provide a balance between robustness and flexibility. In
> practice, many RT tasks, particularly those with lower priorities, are
> used to satisfy latency requirements while still being tightly coupled
> with the scheduling behavior of other workloads. Allowing sched_ext to
> coordinate these tasks may result in better overall scheduling outcomes
> and workload-aware optimizations.
> 

And what's stopping users from doing this today?
I don't think the kernel would be able to decide which RT tasks are
'more critical' than others, and therefore the system administrator can
already downgrade those 'non-critical' RT tasks?
