Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793791911;
	b=PdoXeh6jsj2YIxndf8EA4umEz/y7w/zjbRo8YKnREdiew56aRhG3jbYlr+/+qU5GzVKu
	 4J6OcWZLI+jjQrPmECYV8tgc/B4fSvm5OmfMHBSkEUezeBxxjuu67ozuWOeImL5Q+C636
	 scB2iz1212Yk6T5yqsw/wGNsBwUpED6VOy91WhC+gyk6JHAz6BWqvNONSkztVLSvn+nKZ
	 X0F6q368NF+kllLmoooIoPC6q/cqbUk6eSrzrYGT+0wxmBYFs52DBE82+My+ipg0H3+zL
	 dA0PNX8noGxRtVLYFQItz3fEhfJi1NnGdiO1qlRl00U8MhIWfAfQrwX4J/RWFZdUnAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793791911;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=EDullTK0A0ojCa1/qPo0kHUFNMNAZsYWgwEQhoyO/jY=;
	b=0VqEo2o1MQTjido2dhWZmXhWC/BqK/5T0Lf/VIQY+J80gKv+VnkVlhgGyyxxZ+o+dsPW
	 cw50Xh4ZSK0i2C6rdYgR3ogVwRuubOfXIE4QBfqpjkjnjT9CS7PCd0F8rDtf5aGhNk2JA
	 QFlkgCOjoyX4oMsHdgwLuyzLtIjaMoI/uaDGy5NjIWGVoEUOF26LSpQbVn90m8kMX50SC
	 Of7aw1IcOPJgNadreioRomJ7cSRDfmB//DfyBcjzSXb/21OScqTtQHthvihSUkMp+XNzs
	 /HqJL6/noILOntrIam4jq3rDjCsN0VwtWtAGMfS2ZayWV0WGP5F8pHhF4IbdtlhmAng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bgyoKbqE;
	arc=none smtp.remote-ip=209.85.128.71
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB06606A326
	for <sched-ext@lists.linux.dev>; Wed,  4 Nov 2026 11:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DB06606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bgyoKbqE
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4ad3d35e899so6925495e9.1
        for <sched-ext@lists.linux.dev>; Wed, 04 Nov 2026 03:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793791910; x=1794396710; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EDullTK0A0ojCa1/qPo0kHUFNMNAZsYWgwEQhoyO/jY=;
        b=bgyoKbqE70Dk3brjyBlhv6EFU+W80+In4guteLBGX9QVUjLCbjmltKcRFCsa6ZQN6w
         j0uTpZud8zndDM7QtBkcfjyM/cJ5lASiRjg79d+AKMLbgyzM4UMNrjAo92CGun/vMJJX
         QYi8ydv1dQ5l4POgH61V3m/rzLazrysLrjSEODCOSUDsXi1Dmk/hv5b6bfDab1Icez4B
         d4XdgUMaHCFFPhdqrohVwFUhZxkzX9+vrWw7qC+xXIPi5yxZlygtoy8KaM+Bo88N6KZj
         1l3DeLRFlArIunurbHl78bC+1rQsfpo+XG6rNkXFzqHy3tcdtCR0ISan0X1bslVjND2Y
         Ee8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793791910; x=1794396710;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EDullTK0A0ojCa1/qPo0kHUFNMNAZsYWgwEQhoyO/jY=;
        b=K0kgBoELofm9PqCpjTALmj8K/plzZfVfE6yAv9MuZ6+fLdcLnFUU+mCBBhNneO0F6p
         0yETm0IGeot/QLQPlBmu+XGKM29uousbpsFSt3lIr07eV+72PvDQ2bbh4NUgZLVEVEPf
         +y1AjYl+Iahxls9ytX30HOLQN9bDT4nx/NfQrYAo9zxwLhVuSlUhmi9DJoJCA8Pd3Slj
         27jrbA1Dx44rT29/8LPpdiceAYnSiEk+tcMOBSyEamSo+wHigfdYDAu0Qu5JVYGyX809
         c0oC4WvvaM176bIXbrH7DFL38V4R1kakYzud+7NqL3LR5e2YSV71tAh9DfxYjfetzARh
         TriA==
X-Gm-Message-State: APuU4Z8tRpsnRX1+kPG41armTRGuiA/xTkvihaGRicjitoioYF3OcjLV
	F+ts8RPHZpVGCFVMCzo3tonu1WBtKpbNn5NMBTzaAh4Beo7DWnWHusksW+Vb2zCXJrDiAo0GjLd
	Hsf32n/9ITk+S8A==
X-Received: from wmjv14.prod.google.com ([2002:a7b:cb4e:0:b0:4a1:e780:89af])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:870f:b0:4a2:1612:6367 with SMTP id 5b1f17b1804b1-4ac185bcf74mr348235945e9.15.1793791909664;
 Wed, 04 Nov 2026 03:31:49 -0800 (PST)
Date: Wed, 04 Nov 2026 11:31:49 +0000
In-Reply-To: <sashiko-outbox-195908@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261103190805.3487350-1-jpiecuch@google.com> <20261103190805.3487350-3-jpiecuch@google.com>
 <sashiko-outbox-195908@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DMME0YKQQQ4D.PNR5XMBJHUV7@google.com>
Subject: Re: [PATCH 6.18.y 2/2] sched_ext: Fix scx_flush_disable_work() UAF race
From: Kuba Piecuch <jpiecuch@google.com>
To: <sashiko-reviews@lists.linux.dev>, Kuba Piecuch <jpiecuch@google.com>
Cc: <sched-ext@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Tue Nov 3, 2026 at 7:15 PM UTC, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Critical] sched_ext: premature return in scx_flush_disable_work() on SCX_EXIT_DONE
> --
>
> commit fe0315a0808b95d01cd45741655ca111deb8afc1
> Author: Cheng-Yang Chou <yphbchou0911@gmail.com>
>
> sched_ext: Fix scx_flush_disable_work() UAF race
>
> This commit updates scx_flush_disable_work() to loop while syncing
> sch->error_irq_work and flushing sch->disable_work until sch->exit_kind
> reaches SCX_EXIT_NONE or SCX_EXIT_DONE. This aims to close a race window
> where bpf_scx_unreg() frees the scheduler before a concurrent scx_vexit()
> queues the disable work.
>
>> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
>> index d2460a88fba35..78f15ddc0aa5a 100644
>> --- a/kernel/sched/ext.c
>> +++ b/kernel/sched/ext.c
>> @@ -4217,8 +4217,13 @@ static void scx_disable(struct scx_sched *sch, enum scx_exit_kind kind)
>>   */
>>  static void scx_flush_disable_work(struct scx_sched *sch)
>>  {
>> -	irq_work_sync(&sch->error_irq_work);
>> -	kthread_flush_work(&sch->disable_work);
>> +	int kind;
>> +
>> +	do {
>> +		irq_work_sync(&sch->error_irq_work);
>> +		kthread_flush_work(&sch->disable_work);
>> +		kind = atomic_read(&sch->exit_kind);
>> +	} while (kind != SCX_EXIT_NONE && kind != SCX_EXIT_DONE);
>
> [Severity: Critical]
> Can scx_flush_disable_work() return while sch->disable_work is still
> running if sch->exit_kind transitions to SCX_EXIT_DONE between
> kthread_flush_work() and atomic_read(&sch->exit_kind)?
>
> In scx_disable_workfn(), sch->exit_kind is set to SCX_EXIT_DONE at the
> start of the work function before running scx_root_disable(sch):
>
> kernel/sched/ext.c:scx_disable_workfn() {
> 	...
> 	while (true) {
> 		if (kind == SCX_EXIT_DONE)	/* already disabled? */
> 			return;
> 		WARN_ON_ONCE(kind == SCX_EXIT_NONE);
> 		if (atomic_try_cmpxchg(&sch->exit_kind, &kind, SCX_EXIT_DONE))
> 			break;
> 	}
> 	ei->kind = kind;
> 	ei->reason = scx_exit_reason(ei->kind);
>
> 	scx_root_disable(sch);
> }
>
> If CPU A is in scx_vexit() (or scx_disable()) between scx_claim_exit() and
> queuing the work while CPU B enters bpf_scx_unreg() ->
> scx_flush_disable_work():
>
> 1. On CPU B's first pass, irq_work_sync(&sch->error_irq_work) and
>    kthread_flush_work(&sch->disable_work) return as no-ops because neither
>    work item has been queued yet.
> 2. CPU A then queues sch->error_irq_work (or sch->disable_work), and
>    scx_disable_workfn() starts running on sch->helper, sets sch->exit_kind
>    to SCX_EXIT_DONE, and enters scx_root_disable(sch).
> 3. CPU B executes kind = atomic_read(&sch->exit_kind), observes
>    SCX_EXIT_DONE, and breaks out of the loop without ever having flushed
>    the running sch->disable_work.
>
> Could that allow bpf_scx_unreg() to call kobject_put(&sch->kobj) and return
> to free the BPF struct_ops map while scx_root_disable(sch) and ops.exit()
> are still executing? Would reading sch->exit_kind before syncing and
> flushing (or performing a final kthread_flush_work(&sch->disable_work)
> after the loop) avoid returning before scx_disable_workfn() finishes?

This is an upstream bug, sent a fix for review:
https://lore.kernel.org/all/20261104111449.3984318-1-jpiecuch@google.com/

I will send the fix for 6.18 once it is merged.

I don't think it should block this series. This series reduces the race
window from potentially multi-ms, very easy to reproduce with the right
BPF progs, to a few instructions between the flush and the exit_kind read,
which I failed to reproduce without adding artificial delays in the kernel.

