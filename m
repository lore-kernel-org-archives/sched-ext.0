Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2DB30AD00
	for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776233860; cv=none; b=pPEr9UtOb8wYekJ01q2Ae2M+sjY6vZudoDKpeasQbRAkilWATIOQVL88CAF5Hi0k20xmTzKj8BCHYKivuemyGNh5E8NzfCiJyOfq0GoqKCJIRSOI2DZ2LysRcc4ZPOHACYasYKRWfCLEcTd7U0qs5lSpzUGNCFP0pjGF3+Va4GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776233860; c=relaxed/simple;
	bh=Ztm0YqXKa9aJOg7++yjcKqJ6iKAbkv37UmilDK8SejU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crv7kur9aZ0j9mQcRWfDCbmdilqsroOGODlL+mUXtJ+GgWXdjZIFcY1f1UgfmQ7akKmYXDBBCY4zAwgn7exQlSrL3m/TARrPmi1cTWd0pLQgP+G8yzwmBFVMWT3aDbqQJk/xvXyAIxxMGYTNAbvgRIMgu891qsOHujV9gW5Wlew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sUNrztw5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sUNrztw5"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2addb31945aso38829485ad.1
        for <sched-ext@lists.linux.dev>; Tue, 14 Apr 2026 23:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776233858; x=1776838658; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kdIaq6MRVctdzkUs3epB+MWeaUBr3L2fo8wi6tP3v40=;
        b=sUNrztw5AN6V0j+vyFY99U3yZaK1CbyDwYeFUlACvTRlcUVDRwJLIEhl7G9v4aJNUs
         EbQabERXveX/GCBWv/FCkJBHhCSjPwsBBxwCnTrYgtfq6uUykOtahnsZVEwEqBSZF21h
         N973S6PCDHhA5aXINsqN3Ucv0CkOpbJQP+NxkfqYzPznAHudmOvHvfnKRKDRUOiVU/j3
         feCwKs2VipbP1KSF/YWv33GetAV4rLSUnBow85eDR5SSUasSIBTVmyMuI8mffhZ02whk
         qOucu/adSAKXgkpCpvELjkYbUekEMl+IA2PU1OjACFgMYier1OsQ4fWHMxTPIrznfFQU
         kLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776233858; x=1776838658;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kdIaq6MRVctdzkUs3epB+MWeaUBr3L2fo8wi6tP3v40=;
        b=qdmxyNgPl7pdVtZuIhUhSZ2t1kD+65LWrWSZV8rjoUgKyjd1v+JZ3RqiOpwbiR9+2w
         s4alGQxxzykl6jypus5lVhT/qNZYsg6hqNq/PVntUs6o7XCriPaFPBOF4LpVrhWnJONh
         tO3c/MaHMGPNVc8XOxWh65hf43Oyz0mAfcvnBUQH4stLnbghjt7gYRmvsDuyqJYpTtPc
         sUNM1m0hS5GOflQQdAmlYz8M6Zpw4VDDW7m7yBawY5qkCe2HiggLvEAND58ueNq/6OR1
         YQvBP0tmmqeto70i/3ClKSdMxthxXx7PzY/1fsCeu85hwMB31maBtUQYLaKT2bzUgScE
         HmuQ==
X-Forwarded-Encrypted: i=1; AFNElJ80eekstzhWIcwQygoJuW5sIa8EDkHHqqJFLTP6t9ojx5NRBuKLpRnAalItisBGylD6o3SauSVOAPE=@lists.linux.dev
X-Gm-Message-State: AOJu0YyoYmjSozmQLx16kmhzLEeXY4myjyMXPXYn+hxtDlXfzhZ1sRKR
	bYLSr5hPdXrH3EuifDDsNajxBr8R7dKpb1H0XALkzeEi8Ydr2W7vVAuq
X-Gm-Gg: AeBDies+wiFDumM2mKZlyKXSmQF/DRCFk137V7gBc0qsOTk5zl9MIhHhzIR+quA4S6k
	5zcXo6nT71FRv9oSpXjNDBp2zQBzft9yZdaAGIdVkUk92uV+3jPmyr/FUMzm+547LuNIWBFjqVk
	2T5WZJ9LSud6zChacttAHrAltEWRlEK4f3zQBMcsUAYseHtI8zA8FVO8MJPCFgW1VeSuAGdIhAS
	moSm4AxBNGqG2hC33YuoKMNScBh0W9gvDQLaEAqYqJ0FRoaCmxluUdjwqxvL6EaS6bBUJ7n7j1P
	/EsoPQCJ2ckUEA/wHXTyofpPWY2d+CSabQ+3UVJc2eBa5TjgLgPlAYvn2GRXawK3zmsVWTpZgxR
	Sdz9wuHxQsc59mNfgKm0TiiHki4LikthsgfNictHvIhXHZI0VfZlNUOFCsJhRawX72gMHDJiTdN
	q+OUFtVK2MwwE/bUvnxDUJm4KZ8hA1c5dLto656Uo=
X-Received: by 2002:a17:902:cf04:b0:2b0:5b4e:370c with SMTP id d9443c01a7336-2b2d5a5d686mr219890695ad.32.1776233857604;
        Tue, 14 Apr 2026 23:17:37 -0700 (PDT)
Received: from eric-wcnlab ([2001:288:7001:1099:839f:5f0c:bfd1:44c4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b478135fedsm9656755ad.35.2026.04.14.23.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 23:17:37 -0700 (PDT)
Date: Wed, 15 Apr 2026 14:17:32 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, sched-ext@lists.linux.dev, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH] tools/sched_ext: Handle pinned tasks in scx_central
Message-ID: <3cpy5o3wdfqrmk7kuvwlvibnkesvzprjru5urhyvf66qytnjeu@jibpzykbt65k>
References: <20260413110453.357198-1-yphbchou0911@gmail.com>
 <DHS4U9BLRCPG.1S9E4BT1UIHQT@google.com>
 <s3khi4ec55rog6tgbgxip5skqjdhimcemhwzf3h7pbbvxslnu7@5r4v7jbv4w7z>
 <ad53CFXVxTha3EQu@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gwuaycbi3zhnne6d"
Content-Disposition: inline
In-Reply-To: <ad53CFXVxTha3EQu@slm.duckdns.org>


--gwuaycbi3zhnne6d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tejun,

On Tue, Apr 14, 2026 at 07:19:04AM -1000, Tejun Heo wrote:
> Hello,
> 
> > +	if (p->nr_cpus_allowed == 1)
> > +		return scx_bpf_task_cpu(p);
> > +
> 
> This isn't necessary. select_cpu() isn't called if nr_cpus_allowed == 1.
> 

Ack.

> > @@ -107,12 +113,17 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
> >  	__sync_fetch_and_add(&nr_total, 1);
> >  
> > -	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
> > +	if (p->nr_cpus_allowed == 1 || is_migration_disabled(p)) {
> 
> Let's not expand the condition here. This is to guarantee forward progress
> of the scheduler itself.

Ack.

> > @@ -155,6 +166,13 @@ static bool dispatch_to_cpu(s32 cpu)
> >  		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
> 
> Instead, can you expand the condition above to "if this task can't run on
> the target CPU for whatever reason"?

Done!
 
-- 
Thanks,
Cheng-Yang

--gwuaycbi3zhnne6d
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="v3-0001-tools-sched_ext-Handle-migration-disabled-tasks-i.patch"

From df62cc372cb9fab7aa9b666a6a127d8248923dd8 Mon Sep 17 00:00:00 2001
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
Date: Mon, 13 Apr 2026 15:19:59 +0800
Subject: [PATCH v3 sched_ext/for-7.1] tools/sched_ext: Handle migration-disabled tasks in
 scx_central

When a task calls migrate_disable(), p->cpus_ptr is not updated until
migrate_disable_switch() runs during context switch, so dispatch_to_cpu()
may dequeue such a task and dispatch it to a CPU it cannot run on.

Extend the mismatch check in dispatch_to_cpu() to also test
is_migration_disabled() alongside the cpumask check, so tasks in this
window are bounced to the fallback DSQ.

Suggested-by: Andrea Righi <arighi@nvidia.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Suggested-by: Kuba Piecuch <jpiecuch@google.com>
Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
v3:
 - Drop the select_cpu() shortcut, revert enqueue() to the kthread-only
   forward-progress path, and expand the dispatch_to_cpu() mismatch
   check to cover is_migration_disabled() (Tejun Heo)
 - Drop kick_cpu() on mismatch (Andrea Righi)
 - Reword commit subject and message with the fix

v2:
 - Add is_migration_disabled() check in enqueue() as p->nr_cpus_allowed
   is not updated until migrate_disable_switch() runs during context
   switch, which happens after ops.enqueue(). (Kuba Piecuch)

 tools/sched_ext/scx_central.bpf.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 4efcce099bd5..64dd60b3e922 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -149,10 +149,14 @@ static bool dispatch_to_cpu(s32 cpu)
 		}
 
 		/*
-		 * If we can't run the task at the top, do the dumb thing and
-		 * bounce it to the fallback dsq.
+		 * If we can't run the task at the top for whatever reason,
+		 * bounce it to the fallback dsq. Also check
+		 * is_migration_disabled() explicitly as p->cpus_ptr may not
+		 * reflect the migration-disabled state yet if
+		 * migrate_disable_switch() hasn't run.
 		 */
-		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
+		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr) ||
+		    (is_migration_disabled(p) && scx_bpf_task_cpu(p) != cpu)) {
 			__sync_fetch_and_add(&nr_mismatches, 1);
 			scx_bpf_dsq_insert(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
 			bpf_task_release(p);
-- 
2.48.1


--gwuaycbi3zhnne6d--
