Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1045F299929
	for <sched-ext@lists.linux.dev>; Tue, 13 Jan 2026 05:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768283295; cv=none; b=YVOhHvtXV72/aMkM1CJqKwTJVZJszfHpaFeCG2coIV2ums2RswsOx9EAiO5sSLfYDqdx8eZnJSxhmnYKEEOqpC2aOU6JnAvV/JOPxh71u4In0IlOyvTfNVZ4KBoFyxN2S30vQCfXvHreP8P96DhWLfEMpEKzGaGV3xAgZsgenbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768283295; c=relaxed/simple;
	bh=uyXeC41jbGJXWokM+yK76KnA08gjafFjpNy8Q2YWoz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h503bQ30XzzY4NvfV6ss6xpeox5T8jRAMusrdOqdOCK468Fe4IO0VSfTJXwkDhJ15gYEP3udR653UBKLWMRDxtC+HyRgHhk1qQphu+TNzXX1Qx2EyCJlYQqQKVy3MhZoDrLbj9sZsHZE7eCnFDAY/Q8YzFiVmiMmF/TpN3ihFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WkSMG1ts; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WkSMG1ts"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zi8WTSSBppON+ujvRHeCt+pIYe74CQtvZYPCtmblABc=; b=WkSMG1tslx8GTBKOAzdP/x6e1W
	OhBp4e0OZS5qlCqK0AZhwfpzdF7uIlxgB/3NUsX8ny/rfrPnTh9pOpkN/To401OHnA1vSg2Mwofhf
	QeRCDFCI3K6mm7B5TIbIjO0HLo353Rfzcoh566UAmrE4fBY/QIV4IanenM4NnonutcHo6AUqpf2Vu
	EZil8KOfAH6P2Y8nG9+cCEZoLURBwUN1ysa1XwdONfpN3qGrATN8H1tWSSSsODl0L6nPN1iMqtVpa
	WEtzZ43yBnazszauXfgUuiku/PfmusnGrp5X/wQTETbcaFsMVfRM+Br10heYC+hieZVXBy+hXBJD5
	9E1Mz/wg==;
Received: from [58.29.143.236] (helo=[192.168.1.2])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1vfXG9-004hQs-QJ; Tue, 13 Jan 2026 06:48:06 +0100
Message-ID: <1bee2723-a60f-444b-bdc6-a85249f28096@igalia.com>
Date: Tue, 13 Jan 2026 14:48:01 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] scx_lavd: Optimize CPU selection in pick_idle_cpu
To: dongwanqiang <dongwanqiang2021@gmail.com>
Cc: david.dai@linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev
References: <20260112150724.1553199-1-dongwanqiang@xiaomi.com>
 <DFMQS9YM408T.13HOS5HP1SJJ6@etsalapatis.com>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko, en-HK
In-Reply-To: <DFMQS9YM408T.13HOS5HP1SJJ6@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dong,

Thank you for submitting the patch.

On 1/13/26 1:13 AM, Emil Tsalapatis wrote:
> On Mon Jan 12, 2026 at 10:07 AM EST, dongwanqiang wrote:
>> From: Dong Wanqiang <dongwanqiang@xiaomi.com>
>>
>> Optimize the CPU selection algorithm in pick_idle_cpu() to improve
>> performance in highly loaded systems with multiple compute domains.
>>
>> The current implementation iterates through all neighboring domains
>> without considering distance or early exit conditions, which can
>> lead to unnecessary iterations when no idle cores are available.
>>
>> Changes:
>> 1. Add tracking of stealer domains found at each distance level
>> 2. Skip domains without idle cores early (nr_idle_cores == 0)
>> 3. Add early exit when stealer domains are found but no idle cores
>>     are available in closer domains
>> 4. Add optimization comments explaining the improvements
>>
>> These changes reduce the search time in the critical path while
>> maintaining the same task migration behavior and load balancing
>> characteristics.
>>
>> Signed-off-by: Dong Wanqiang <dongwanqiang@xiaomi.com>
> 
> The scx_lavd scheduler is not in the kernel repo, can you open a PR
> at https://github.com/sched-ext/scx?

As Emil suggested, please open a PR on the GitHub repo. For the SCX
schedulers that are not in the kernel tree, we discuss and accept
patches through GitHub. We can discuss the technical details there to
keep the history in one place.

Regards,
Changwoo Min


> 
>> ---
>>   scheds/rust/scx_lavd/src/bpf/idle.bpf.c | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/scheds/rust/scx_lavd/src/bpf/idle.bpf.c b/scheds/rust/scx_lavd/src/bpf/idle.bpf.c
>> index 9f08f972..4340f453 100644
>> --- a/scheds/rust/scx_lavd/src/bpf/idle.bpf.c
>> +++ b/scheds/rust/scx_lavd/src/bpf/idle.bpf.c
>> @@ -757,10 +757,15 @@ s32 __attribute__ ((noinline)) pick_idle_cpu(struct pick_ctx *ctx, bool *is_idle
>>   		goto skip_fully_idle_neighbor;
>>   
>>   	mig_cpdom = sticky_cpdom;
>> +	/* Optimization: Prioritize closer domains and add early exit conditions */
>>   	bpf_for(i, 0, LAVD_CPDOM_MAX_DIST) {
>>   		nr_nbr = min(cpdc->nr_neighbors[i], LAVD_CPDOM_MAX_NR);
>>   		if (nr_nbr == 0)
>>   			break;
>> +
>> +		/* Track if we found any stealer domains at this distance */
>> +		bool found_stealer_at_dist = false;
>> +
>>   		bpf_for(j, 0, LAVD_CPDOM_MAX_NR) {
>>   			if (j >= nr_nbr)
>>   				break;
>> @@ -772,6 +777,12 @@ s32 __attribute__ ((noinline)) pick_idle_cpu(struct pick_ctx *ctx, bool *is_idle
>>   			if (!mig_cpdc || !READ_ONCE(mig_cpdc->is_stealer))
>>   				continue;
>>   
>> +			found_stealer_at_dist = true;
>> +
>> +			/* Quick check: skip domains without idle cores */
>> +			if (mig_cpdc->nr_idle_cores == 0)
>> +				continue;
>> +
>>   			cpu = pick_idle_cpu_at_cpdom(ctx, mig_cpdom, SCX_PICK_IDLE_CORE, is_idle);
>>   			if (cpu >= 0) {
>>   				/*
>> @@ -789,6 +800,11 @@ s32 __attribute__ ((noinline)) pick_idle_cpu(struct pick_ctx *ctx, bool *is_idle
>>   				goto unlock_out;
>>   			}
>>   		}
>> +
>> +		/* Early exit: if we found stealer domains but no idle cores,
>> +		 * it's unlikely to find idle cores in farther domains */
>> +		if (found_stealer_at_dist && i > 0)
>> +			break;
>>   	}
>>   skip_fully_idle_neighbor:
>>   	/* NOTE: There is no fully idle CPU in the neighboring domain,
> 
> 

