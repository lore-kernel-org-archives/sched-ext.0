Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5E521FF46
	for <sched-ext@lists.linux.dev>; Wed,  3 Sep 2025 20:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756931881; cv=none; b=ia94E1/W5l21OSlcnER3E1mloF/yAG2B4sh/pARYAfREmgGWjC6LGJ28DS3HH63TziMmuss/0P6z9I6jOeku165t1RW8bJN6jvQiQ9Oy7xortwJ8Imih9qvMwR0pZG7onw4Wt+m9mpIdJ2+DEImNoK3sYGq10kJUTfdU4NZhlG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756931881; c=relaxed/simple;
	bh=uKu8S39LMZPkk9uPU/gev0Ffo2LUCTJHd4AdQN9gLgo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBWDiTlZ8JbpLGRM1zNm3rOWekNzmCws7Tmk9+5gDOa4itiWKaTBj8XkUxIPTMdpQsWeMrpYVgvjSg2hVr+r84H9gpxk710QXFpwiQ3NKaGocDlxtcLn7r2yYY1xN13sXmAC4HBciQh7QR3Yc+yHx6jqx8A8qEitqxkONvLciiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DE4DB1688;
	Wed,  3 Sep 2025 13:37:48 -0700 (PDT)
Received: from [10.57.93.203] (unknown [10.57.93.203])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD7A23F6A8;
	Wed,  3 Sep 2025 13:37:55 -0700 (PDT)
Message-ID: <8559c7d7-2171-4d86-8334-7e8442e96b9a@arm.com>
Date: Wed, 3 Sep 2025 21:37:54 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/3] sched_ext: deprecation warn for scx_bpf_cpu_rq()
To: Tejun Heo <tj@kernel.org>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
 mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
References: <20250901132605.2282650-1-christian.loehle@arm.com>
 <20250901132605.2282650-5-christian.loehle@arm.com>
 <aLhlPaa_lLFPnX2A@slm.duckdns.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aLhlPaa_lLFPnX2A@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/3/25 16:56, Tejun Heo wrote:
> On Mon, Sep 01, 2025 at 02:26:04PM +0100, Christian Loehle wrote:
>> scx_bpf_cpu_rq() works on an unlocked rq which generally isn't safe.
>> For the common use-cases scx_bpf_cpu_rq_locked() and
>> scx_bpf_remote_curr() work, so add a deprecation warning
>> to scx_bpf_cpu_rq() so it can eventually be removed.
>>
>> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
>> ---
>>  kernel/sched/ext.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index e242a2520f06..a524d404ad09 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -7427,6 +7427,9 @@ __bpf_kfunc struct rq *scx_bpf_cpu_rq(s32 cpu)
>>  	if (!kf_cpu_valid(cpu, NULL))
>>  		return NULL;
>>  
>> +	pr_warn_once("%s() is deprecated; use scx_bpf_cpu_rq_locked() when holding rq lock "
>> +		     "or scx_bpf_remote_curr() to read remote curr safely.\n", __func__);
>> +
> 
> I wonder whether it'd make more sense to tie the once testing to the
> scheduler instance (see warned_zero_slice).
> 
Yes that makes sense to me, I'll resend with this and the renaming suggestions.
Thanks!
