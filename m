Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46802868AB;
	Sat, 11 Apr 2026 14:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775918283; cv=none; b=Gnz9w4TjC6Ynt5GQeie2DuakOJpF6JU4dEmr0SFhR7JM0qZvxOWuKnamV3pV/hcBAJdZ2QlpInaubEe/+57SWuhxDx+S7bpwycQof1aR8QJysSvoWTLShFbUXYK/t2WFswqXgX2Tcjs2/KSZJ0NW628ASwyj8wHDGQ5sPuADYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775918283; c=relaxed/simple;
	bh=dsyyQzGsS3A6hFqbIbgHeanM8UgrZIL8VdOZWZQm288=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sDujtkq4vk3MpjE89zsMOv/Vb7kFvJh/deFWCv15RHIOoBnwHERUsmctDoPxgJs8t3O36Ri99yAssjs1OMzXTp8lqPH7NgTxfuXbNdAHa2IPyvndIYU4YF7WIMAjCmbt9bj7MrwZe2/Mpg7FmEbvjhNqm3+kWVisUtuzE4oMbWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=nBao8OaW; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="nBao8OaW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HBRt4QSEOwBBAhu5S/+S8lTob8S6BCke2ARXTFLjTJc=; b=nBao8OaWtcoBdR8t8Lp620XNOq
	uHa+2BMtVv+S17a/T+hi4e6hyOM9hnv6RzMo6lORC2gqhNAxgUNnJKqD9wrkipJEwO3Ah72sqtnfG
	alftTVK//4Xb+oyoEoKtTK9CHlXILxkignFVjmG4bekCjGVaZIlzkJhSztE524RI22wA0ug23HbZ0
	qfc6sf9CKCvv2Xf3+BSsSVa14bBOOkoEovRrQg49eCqXGcN8xYRCvWn/bJ54JADgwpdDxDYyRL3ky
	9Dg4yce6E7ZAf+S+XUxyXtb0qmK7dcFDYYyCxr+yx2LtTmPD8LglgQKGaQXvzb49abYIIqcWN1nrY
	6fsMpLuw==;
Received: from [58.29.145.179] (helo=[192.168.123.154])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1wBZT3-00EmOP-Gq; Sat, 11 Apr 2026 16:37:50 +0200
Message-ID: <f748b81f-ed84-48d9-8ca4-9ac7865181ee@igalia.com>
Date: Sat, 11 Apr 2026 23:37:42 +0900
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sched_ext: Dump the stall CPU first in watchdog exit
To: Andrea Righi <arighi@nvidia.com>
Cc: tj@kernel.org, void@manifault.com, kernel-dev@igalia.com,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260408031113.76005-1-changwoo@igalia.com>
 <20260408031113.76005-3-changwoo@igalia.com> <adc81Une7-LrDLrR@gpd4>
From: Changwoo Min <changwoo@igalia.com>
Content-Language: en-US, ko-KR, en-US-large, ko
In-Reply-To: <adc81Une7-LrDLrR@gpd4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Andrea,


On 4/9/26 2:44 PM, Andrea Righi wrote:
> Hi Changwoo,
> 
> On Wed, Apr 08, 2026 at 12:11:13PM +0900, Changwoo Min wrote:
>> When a watchdog timeout fires, the CPU where the stalled task was
>> running is the most relevant piece of information for diagnosing the
>> hang. However, if there are many CPUs, the dump can get truncated and
>> the stall CPU's information may not appear in the output.
>>
>> Add a stall_cpu field to scx_exit_info, thread it through scx_vexit()
>> and __scx_exit(), and populate it from cpu_of(rq) in
>> check_rq_for_timeouts(). In scx_dump_state(), dump the stall CPU
>> before iterating the rest so it always appears at the top of the output.
>>
>> Introduce a scx_exit() macro that wraps __scx_exit() with stall_cpu=0
>> for all non-stall exit paths, keeping call sites unchanged.
> 
> Should we use stall_cpu = -1 as a sentinel to represent "no stall"?

I think initializing stall_cpu to 0 has advantages: since CPU 0 cannot
be turned off and is always valid, even if a task stall didn’t happen,
the first scx_dump_cpu() call is always valid.

> 
>>
>> Signed-off-by: Changwoo Min <changwoo@igalia.com>
>> ---
>>   kernel/sched/ext.c          | 31 ++++++++++++++++++++-----------
>>   kernel/sched/ext_internal.h |  3 +++
>>   2 files changed, 23 insertions(+), 11 deletions(-)
>>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index 8f7d5c1556be..671a1713aedb 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -200,24 +200,28 @@ static bool task_dead_and_done(struct task_struct *p);
>>   static void scx_kick_cpu(struct scx_sched *sch, s32 cpu, u64 flags);
>>   static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind);
>>   static bool scx_vexit(struct scx_sched *sch, enum scx_exit_kind kind,
>> -		      s64 exit_code, const char *fmt, va_list args);
>> +		      s64 exit_code, int stall_cpu, const char *fmt,
>> +		      va_list args);
>>   
>> -static __printf(4, 5) bool scx_exit(struct scx_sched *sch,
>> -				    enum scx_exit_kind kind, s64 exit_code,
>> -				    const char *fmt, ...)
>> +static __printf(5, 6) bool __scx_exit(struct scx_sched *sch,
>> +				      enum scx_exit_kind kind, s64 exit_code,
>> +				      int stall_cpu, const char *fmt, ...)
>>   {
>>   	va_list args;
>>   	bool ret;
>>   
>>   	va_start(args, fmt);
>> -	ret = scx_vexit(sch, kind, exit_code, fmt, args);
>> +	ret = scx_vexit(sch, kind, exit_code, stall_cpu, fmt, args);
>>   	va_end(args);
>>   
>>   	return ret;
>>   }
>>   
>> +#define scx_exit(sch, kind, exit_code, fmt, args...)				\
>> +					__scx_exit(sch, kind, exit_code, 0, fmt, ##args)
>> +
>>   #define scx_error(sch, fmt, args...)	scx_exit((sch), SCX_EXIT_ERROR, 0, fmt, ##args)
>> -#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, fmt, args)
>> +#define scx_verror(sch, fmt, args)	scx_vexit((sch), SCX_EXIT_ERROR, 0, 0, fmt, args)
>>   
>>   #define SCX_HAS_OP(sch, op)	test_bit(SCX_OP_IDX(op), (sch)->has_op)
>>   
>> @@ -3433,9 +3437,10 @@ static bool check_rq_for_timeouts(struct rq *rq)
>>   					last_runnable + READ_ONCE(sch->watchdog_timeout)))) {
>>   			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
>>   
>> -			scx_exit(sch, SCX_EXIT_ERROR_STALL, 0,
>> -				 "%s[%d] failed to run for %u.%03us",
>> -				 p->comm, p->pid, dur_ms / 1000, dur_ms % 1000);
>> +			__scx_exit(sch, SCX_EXIT_ERROR_STALL, 0, cpu_of(rq),
>> +				   "%s[%d] failed to run for %u.%03us",
>> +				   p->comm, p->pid, dur_ms / 1000,
>> +				   dur_ms % 1000);
>>   			timed_out = true;
>>   			break;
>>   		}
>> @@ -6337,8 +6342,11 @@ static void scx_dump_state(struct scx_sched *sch, struct scx_exit_info *ei,
>>   	dump_line(&s, "CPU states");
>>   	dump_line(&s, "----------");
>>   
>> +	/* Dump the stall CPU first, then dump the rest in order. */
>> +	scx_dump_cpu(sch, &s, &dctx, ei->stall_cpu, dump_all_tasks);
> 
> And here we can skip this if ei->stall_cpu < 0.

As mentioned earlier, even if stall_cpu is not set, scx_dump_cpu() for
CPU 0 is always valid, so the additional if statement is not necessary.
I can add comments here to avoid potential confusion in the future,
instead of initializing stall_cpu to -1. What do you think?

> 
>>   	for_each_possible_cpu(cpu) {
>> -		scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
>> +		if (cpu != ei->stall_cpu)
>> +			scx_dump_cpu(sch, &s, &dctx, cpu, dump_all_tasks);
>>   	}
>>   
>>   	dump_newline(&s);
>> @@ -6377,7 +6385,7 @@ static void scx_disable_irq_workfn(struct irq_work *irq_work)
>>   }
>>   
>>   static bool scx_vexit(struct scx_sched *sch,
>> -		      enum scx_exit_kind kind, s64 exit_code,
>> +		      enum scx_exit_kind kind, s64 exit_code, int stall_cpu,
>>   		      const char *fmt, va_list args)
>>   {
>>   	struct scx_exit_info *ei = sch->exit_info;
>> @@ -6400,6 +6408,7 @@ static bool scx_vexit(struct scx_sched *sch,
>>   	 */
>>   	ei->kind = kind;
>>   	ei->reason = scx_exit_reason(ei->kind);
>> +	ei->stall_cpu = stall_cpu;
>>   
>>   	irq_work_queue(&sch->disable_irq_work);
>>   	return true;
>> diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
>> index b4f36d8b9c1d..a0a09e8f2ac2 100644
>> --- a/kernel/sched/ext_internal.h
>> +++ b/kernel/sched/ext_internal.h
>> @@ -93,6 +93,9 @@ struct scx_exit_info {
>>   	/* %SCX_EXIT_* - broad category of the exit reason */
>>   	enum scx_exit_kind	kind;
>>   
>> +	/* CPU where a task stall happened. */
>> +	int			stall_cpu;
>> +
> 
> With CO-RE we shouldn't have any compatibility issue, but would it make sense to
> move this at the end of the struct anyway?

I wanted to fill the 4-byte hole between kind and exit_code. If there is
no compatibility issue, I would prefer to fill the hole and colocate the
high-level information, like kind and exit_code, together rather than
placing it after the messages. However, this is a matter of taste, so I
don’t have a strong opinion here.

Regards,
Changwoo Min
> 
>>   	/* exit code if gracefully exiting */
>>   	s64			exit_code;
>>   
>> -- 
>> 2.53.0
>>
> 
> Thanks,
> -Andrea
> 

