Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4A02E7629
	for <sched-ext@lists.linux.dev>; Tue, 12 Aug 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989673; cv=none; b=XoA64ys9qondMepjYsyc6c/Rw2oJRHvgP99kTZai9vWqXhPPV7GGNZxns8X/Lymx6WpH66anINQJrQnS8u0df1qSBg6D1CiXxA5GGII1ShCmc7RZPaAyqXfFJxURl4Kt4Z2Doh/h/cP/X+9ZzRMjL9CHCiUwYkubvcRA26j2Gfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989673; c=relaxed/simple;
	bh=BSyVqA0WE/LnCMOkpVe7F5LcO/3lVqy1k6UvLduegSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrJ64pQsZZhOuUx0cnInETikczk69wez1LyryigxYFBAi689zytBoLWulQIXZoytq1hmMa1jutB/e/SYCHR6odZeYL8Sa+Hxiy4dZvh/poFH6srLcDGi0GdnrnOwL0W6B9wVauucvxZhbie9HUC52gg9VOT+WBkmKiOdsl1JwOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37C0925E1;
	Tue, 12 Aug 2025 02:07:42 -0700 (PDT)
Received: from [10.1.37.57] (unknown [10.1.37.57])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52F2C3F63F;
	Tue, 12 Aug 2025 02:07:48 -0700 (PDT)
Message-ID: <356a3c25-9c7c-41a5-a88e-ceeaf8405641@arm.com>
Date: Tue, 12 Aug 2025 10:07:46 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] sched_ext: Introduce scx_bpf_cpu_rq_locked()
To: Tejun Heo <tj@kernel.org>
Cc: arighi@nvidia.com, void@manifault.com, linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev, changwoo@igalia.com, hodgesd@meta.com,
 mingo@redhat.com, peterz@infradead.org, jake@hillion.co.uk
References: <20250811212150.85759-1-christian.loehle@arm.com>
 <20250811212150.85759-2-christian.loehle@arm.com>
 <aJp-2TPbNKO3k_lq@slm.duckdns.org>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <aJp-2TPbNKO3k_lq@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/12/25 00:38, Tejun Heo wrote:
> Hello,
> 
> On Mon, Aug 11, 2025 at 10:21:48PM +0100, Christian Loehle wrote:
>> +/**
>> + * scx_bpf_cpu_rq_locked - Fetch the locked rq of a CPU
>> + * @cpu: CPU of the rq
>> + */
>> +__bpf_kfunc struct rq *scx_bpf_cpu_rq_locked(s32 cpu)
>> +{
>> +	struct rq *rq;
>> +
>> +	if (!kf_cpu_valid(cpu, NULL))
>> +		return NULL;
>> +
>> +	preempt_disable();
>> +	rq = cpu_rq(cpu);
>> +	if (rq != scx_locked_rq()) {
>> +		scx_kf_error("Accessing not locked rq %d", cpu);
>> +		rq = NULL;
>> +	}
>> +	preempt_enable();
>> +	return rq;
>> +}
> 
> Do we need @cpu? What do you think about making the function not take any
> arguments and just return the locked rq?

Indeed now that this no longer has to be a drop-in replacement.
