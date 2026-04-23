Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE23E5EE7
	for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 09:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937695; cv=none; b=T3ltggzL0js21Jb7zwUm4cqijz9YCOnaKV1ecaanNqehtHuVl7UT9ohporFZfOc9oZBzsHD5cbkSGzzyXQLU0u7IVSOk1cXh6WchhjEqUXqqZh0CWegD/3m9cvqKIRiQcke69c3R/oRwkrHo/U3wQlkKeTzRwBcCFHDFxkvZU40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937695; c=relaxed/simple;
	bh=isUGdThoupT1njkgBQnVVrdFvbO/3BNw0h/VGihjLec=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U54av/DGhIWyFVYQt5oGl3JOStmSSBLRRwwjxsxa518sHy2jESgUfpBH1dkFsSQm5KGUN2+/Yn47DsKaFZf1Svq+6wH3RUH6eRNxF2LyO9OdHNh6GYZG5SeuYtAezYnKcKBrJyjbFZH2uG4wAayPpmGsfl8l1Smgbb/MugjWVWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c602HmJW; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c602HmJW"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-488d56f87e8so54558425e9.0
        for <sched-ext@lists.linux.dev>; Thu, 23 Apr 2026 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776937693; x=1777542493; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hl1kWGbH9q/qjzDK/ZdU4A22sT2z4nhW5mix2FM6i4=;
        b=c602HmJWyRytkGDZvAlRcvSxpBZMSM2QoumpDfxRYcqkixb+7XPrZAeAwHpFJyco6M
         yeSBopXu3fIMDV5ThySuifr+F3VBHbRdpyjkrNIlsrdscuIzhC9PIGNe9j6T1nwfsMYP
         0469uBnh3Z7shSe0UVyJuwdK7pLhXGUCCJyj9o4AssPpu7rYsUc1sysQ/V2cDaHtRnAz
         OD71Ef768detwl6gSsuCPNs5wboCZWgEr69EDPpJLEPfnVHz1sIny9KPFt8JIO8oGLN5
         SMkbXSQTwkFP8UVgQhp29XreR+Vwju8AVGUjjW9PMo8W3kMice3GPUiyEkHDs5WeWkqA
         pJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776937693; x=1777542493;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Hl1kWGbH9q/qjzDK/ZdU4A22sT2z4nhW5mix2FM6i4=;
        b=HpD2nIBYp7/YdFuyaxj0k47FzZEf1LeMpINHbzl0e+uU1Wb296BH3kPYbmr8xeMDut
         IHiznQhT6jDw+XnS4JXWPJ41o3WUIZSptJNCYMQRRE06ILYSzxSxkUrlCRrfzcrvPZI4
         6oJnzN0YjgKTJTLj9bA6eT3CIKuPvk5R34A2fiusSHwl0MaqXjADo2iiGgC4/70oasge
         mncxBilec7ysaI46EW4hg8FLkRoV4wbZju+aXOrgwWw1jIKh+dK1cgW40d3zJKHS4IOR
         HV5nGwRqgu9LGnir3Puc5HH9dxBSNTiCHms+cDMkgdmfEN806nPQEHmEzRgh/v4Od8Ma
         xm4w==
X-Forwarded-Encrypted: i=1; AFNElJ/4g1UXYjl4spFXCXbgesqoSPL2e+1qRh25UUM6oSBoNDBlGBvBb8LxHxQocMyrB0zE6VT5IdawLFQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJaQMiuDJzTnORPX46Irr2R9Un9HhPaI/BBZGm+OcDX+Dg/vOw
	ONmILwXziEDFBkEFMk+TcMOpJDXDRNXxU08+Z+QBeial7kkuObvv2o2nWugfhx7QBwlSUxEiTZj
	pihwyF2uhvpnI8Q==
X-Received: from wmro12.prod.google.com ([2002:a05:600c:378c:b0:488:c2a4:dd33])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a305:b0:48a:53cb:85f4 with SMTP id 5b1f17b1804b1-48a53cb8734mr145926305e9.24.1776937692621;
 Thu, 23 Apr 2026 02:48:12 -0700 (PDT)
Date: Thu, 23 Apr 2026 09:48:11 +0000
In-Reply-To: <aej8cmhZVhsqogr4@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <DHZPHUFXB4N3.2RY28MUEWBNYK@google.com> <aej8cmhZVhsqogr4@slm.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DI0FTX13UW17.1IZJ9TMG9EFRA@google.com>
Subject: Re: SCX_ENQ_IMMED potentially leaving dispatched tasks lingering on
 local DSQs
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	David Vernet <void@manifault.com>, <linux-kernel@vger.kernel.org>, 
	<sched-ext@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Wed Apr 22, 2026 at 4:50 PM UTC, Tejun Heo wrote:
> Hello, Kuba.
>
> On Wed, Apr 22, 2026 at 01:21:27PM +0000, Kuba Piecuch wrote:
>> diff --git i/kernel/sched/ext.c w/kernel/sched/ext.c
>> index d66fea57ee69..480627fdc203 100644
>> --- i/kernel/sched/ext.c
>> +++ w/kernel/sched/ext.c
>> @@ -3079,8 +3079,11 @@ do_pick_task_scx(struct rq *rq, struct rq_flags *rf, bool force_scx)
>>          * If @force_scx is true, always try to pick a SCHED_EXT task,
>>          * regardless of any higher-priority sched classes activity.
>>          */
>> -       if (!force_scx && rq_modified_above(rq, &ext_sched_class))
>> +       if (!force_scx && rq_modified_above(rq, &ext_sched_class)) {
>> +               if (rq->scx.nr_immed)
>> +                       schedule_reenq_local(rq, 0);
>>                 return RETRY_TASK;
>> +       }
>> 
>>         keep_prev = rq->scx.flags & SCX_RQ_BAL_KEEP;
>>         if (unlikely(keep_prev &&
>
> Ah, good catch.
>
>> ...but I think this only fixes the case where the RT task wakes up on the CPU
>> that is doing the dispatch. The other case is one where the RT task wakes up
>> on the remote CPU (the one the second task was dispatched to) after insertion
>> of the second task, assuming the remote CPU is initially idle.
>> 
>> To fix both cases, one potential solution that comes to mind is bumping
>> rq->next_class to &ext_sched_class when inserting a task into rq->scx.local_dsq.
>> Perhaps we should call wakeup_preempt() in dispatch_to_local_dsq()?
>
> I think what's missing is wakeup_preempt() call in
> move_remote_task_to_local_dsq(). This is SCX's version of move_queued_task()
> and we're missing wakeup_preempt() call after activate_task().

I'm not sure if we should limit ourselves to just remote tasks.
If we call wakeup_preempt(rq, p, flags) when adding @p to @rq's local DSQ
regardless of whether @p/@rq is remote, then I think that should cover all
cases and the patch above wouldn't be needed.

Perhaps local_dsq_post_enq() would be a good place to invoke wakeup_preempt()?

Thanks,
Kuba
