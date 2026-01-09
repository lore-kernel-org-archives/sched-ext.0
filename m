Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5D31A9F93
	for <sched-ext@lists.linux.dev>; Fri,  9 Jan 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767988955; cv=none; b=hmsmdiFciPuK8BkWMOxn1MPojelsrfrQP/G+7NR2q21KfumlW5yZAkMpNGFVQOIvWChDl6qmGbp0aFXVUEqiKnQFx12OI1Rd/sQw+GVAt8aKx1gIqjpvFnGTj08G0VwgijAH6MsCnXB26tN4vB9A3p38Tqbhj8XfWWxuonlNs/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767988955; c=relaxed/simple;
	bh=T2AnrZhy8z0EdoF+y5TaqE29gIDEZiUOpkM4ZU58I7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMUralskp3YpoZE8PiyMPnq9RRCz5fZiUOuqttPrd0AkKgr/3SiLW3AUXsnPiWef5YrORWuM7V4ZvS7hdv74blLcKplu1oYR2p/Mrq2kDIrEUEkx2e96UcznHRz05C9iBqD9AzWRNtMpgPYsOd8FSpDu4RNdSTXdtSQLVL2rd10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ApajLa92; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ApajLa92"
Message-ID: <b099a95e-5e69-4eeb-a2c9-9a52b8042a85@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767988949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oYFeakxGOXtPhmmcFIB113t2tmC+9p9TQG0yTPi7vpI=;
	b=ApajLa92Mz07Z8FuxQYdwjUOGUrNSgUys7/Xnnce9L08jWFlbLw8L5VItKkj6pi05pRuUK
	+pJm9k+yTWO29ALXEQrzCFXxteMDeKVXgfnn10K/QyWc6WRcz5VrOre81QpLmASfpIQCwJ
	0HKvbE28LJ+LKwewou4jMfqK86FoVlM=
Date: Fri, 9 Jan 2026 12:02:21 -0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 08/10] bpf: Add bpf_task_work_schedule_*
 kfuncs with KF_IMPLICIT_ARGS
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>,
 Tejun Heo <tj@kernel.org>, Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
 sched-ext@lists.linux.dev
References: <20260109184852.1089786-1-ihor.solodrai@linux.dev>
 <20260109184852.1089786-9-ihor.solodrai@linux.dev>
 <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQJDv80_T+1jz=7_8y+8hRTjMqqkm38in2er8iRU-p9W+g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 1/9/26 11:58 AM, Alexei Starovoitov wrote:
> On Fri, Jan 9, 2026 at 10:50 AM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> +__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
>> +                                             void *map__map, bpf_task_work_callback_t callback,
>> +                                             struct bpf_prog_aux *aux)
>> +{
>> +       return bpf_task_work_schedule(task, tw, map__map, callback, aux, TWA_SIGNAL);
>> +}
>> +
>>  __bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_struct *task,
>>                                                    struct bpf_task_work *tw, void *map__map,
>>                                                    bpf_task_work_callback_t callback,
>>                                                    void *aux__prog)
>>  {
>> -       return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
>> +       return bpf_task_work_schedule_signal(task, tw, map__map, callback, aux__prog);
>>  }
> 
> I thought we decided that _impl() will not be marked as __bpf_kfunc
> and will not be in BTF_ID(func, _impl).
> We can mark it as __weak noinline and it will be in kallsyms.
> That's all we need for the verifier and resolve_btfid, no?
> 
> Sorry, it's been a long time. I must have forgotten something.

For the *generated* _impl kfuncs there is no decl tags and the ids are
absent from BTF_ID sets, yes.

However for the "legacy" cases it must be there for backwards
compatibility, as well as relevant verifier checks.
