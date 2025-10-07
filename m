Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC102E5B32
	for <sched-ext@lists.linux.dev>; Tue,  7 Oct 2025 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850611; cv=none; b=jXQIs6M0Q4pAC8yp1z3B6UYbb02b3TdxQhtyPQp5u9VaRq+8CHieblzUQpirKsDr6B1BAy10MWT+lzNc0uQNn7Gk/9zBnBCnn75jTIawY8sycnNK++thwbVdIvLizYU7Y08uRc2Q7by2UlwOErKordXp+2QYzdZI6zJixmqT3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850611; c=relaxed/simple;
	bh=Qaixh/0h0CexTahBH/Nbesb7dLvjfql5jNJYxSlQ13U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lmXFD+LrsSCqmOw/jT3/HXe7uy+OB+F1epQvE4fRd6o3XOpelEaPX8bdteOk331f/FID8E3ZonFTKtVQYPpKSXoRFsWl5couCDwBjJw9OeonGLTn9Eth6TUgFBoMY7cFtfOQ3tAGXIGASBVvmJ50efo4UYtodBxHChV3pkqLeTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qnXMcfdc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qnXMcfdc"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78ead12so1160073966b.1
        for <sched-ext@lists.linux.dev>; Tue, 07 Oct 2025 08:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759850608; x=1760455408; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UwG9PZuipETG7rnRpTzxcF+1B6JYfXyf2MeSzyquatI=;
        b=qnXMcfdcwGluqlvJKwCtVSU++jTh8R46SfoutcJyI6K2m5cVAhNof8rFJH35l8Sdq9
         Tr7PyV5IsaBS27f7puWLccnKd8yG447qwngSmTl4VF1j2g2lqZoojsczyotEktNTuqXj
         tos2FKHS1MLQKkIH+1JlO42QTZ35ZSvPF7EDgOy9yOLPHwk2t2RGZpNh6aHfAA/OzVjS
         V+FQBDtvfcjLhhOM7khSgLgGS57r0dA/5zBm9x6jWlPC+eRfO1LRHe4xdxq/2b8c3lfZ
         0KPtBEXHnQlFmOzTITbV7o/3hgSaQlLgvtZaTmunhV/RhM8pk9JM/hWY5nHU2rrK+bQv
         7WdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850608; x=1760455408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UwG9PZuipETG7rnRpTzxcF+1B6JYfXyf2MeSzyquatI=;
        b=rOx+73wYibZqQHekjoxbZwDKSLemSGiN5fyB6MR2wfmBNPs9XLmQLXNmQ93HLOysbx
         R+B/vaPZ0wxabnkQ8wAo63lCcsW2q0BgPtxG4uJdYjTsCh9M2eZD93QEKDos18hnQ1x1
         mzjugfsQox9XW8KNu/CifiFsckX7oUWTkMNLs5ldhWwrqKM3r3sm8aa8Pv/S+bOySzIk
         LuHQ3Fz9rDoJFf7E3loichxRioqN4LYn3HWLwgA9bBeZ2RysagIsI4wKvj88FfMxFWeE
         Jw1mREE60ts6WnGG7R1Jeb3wvgPvwRfH2EWjKkg1kPQJDhxTXy/riwruiVrA1Jd1I388
         lLIg==
X-Forwarded-Encrypted: i=1; AJvYcCWipkrSLruQc+fiqG+NpqoK95R/nyjM7tWG3uDdKWN/52TPHFV63gHvV/tQBdw4FYnWDzKBZ4C4z+s=@lists.linux.dev
X-Gm-Message-State: AOJu0YxipjtyM0NWd9v4ZZp7wwzjJAJfhkKymDy50S8AbMFVfG+D3dQc
	KXmfCoLFHDihO0KKxFyuQqkHfreRfhNAC3k7BOntwzqz/8r6X7LABGex0Sy+L5U4t5JHhfbNCU8
	8pn5FPyhN5WthtKABwmznsu8XLYGIep9uQC7A5izwtA==
X-Gm-Gg: ASbGncsEQkky+L9gcPE8d14RhEwSAEvD1BmcQUSi33Ef+QXVCX390yjZpAAp5If9U40
	yCnePLlsMvhlrErqZy2IEG9XkQlagaqtC/ZY6WMWZX72EA43OKniO3iUzo9y8XqZf3zcBy78iuL
	tPD9fXHdIqrtFsJnbOVXqTTh6f58fFthBed4BKVUnwNvi2aJXiJVHmQ9YjuS883q43yiE15/X3W
	x2z3gnjbHAa6g8rqSFA8wnziZ8pwzveI3z2XA/xIGfWVCBO6znk3iogGME1/zEpIny0Bk4xew==
X-Google-Smtp-Source: AGHT+IFY9nkxh1XrpxsOJhE6hryneAH5gLOUnE5EpF4NzhHNwlkHm8SbyiGn3ZVrorhgVsPBNdhy5CzpeJS0xykTtj8=
X-Received: by 2002:a17:907:97d3:b0:b04:67f3:890f with SMTP id
 a640c23a62f3a-b49c3d753d4mr2301349966b.33.1759850607427; Tue, 07 Oct 2025
 08:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251006104402.946760805@infradead.org>
In-Reply-To: <20251006104402.946760805@infradead.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 7 Oct 2025 17:23:13 +0200
X-Gm-Features: AS18NWAxqcxGakptEBnQb48nrcpm15RhoPtf2PjFIcOjN0vV7OYV5xWrjVCaxFw
Message-ID: <CAKfTPtB5i+5rqkuU8Q4D9fUGAnjKCqNR_y82ZAHHgJdFgcOTnw@mail.gmail.com>
Subject: Re: [PATCH 00/12] sched: Cleanup the change-pattern and related locking
To: Peter Zijlstra <peterz@infradead.org>
Cc: tj@kernel.org, linux-kernel@vger.kernel.org, mingo@kernel.org, 
	juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
	bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, longman@redhat.com, 
	hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
	changwoo@igalia.com, cgroups@vger.kernel.org, sched-ext@lists.linux.dev, 
	liuwenfang@honor.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

On Mon, 6 Oct 2025 at 12:46, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Hi,
>
> There here patches clean up the scheduler 'change' pattern and related locking
> some. They are the less controversial bit of some proposed sched_ext changes
> and stand on their own.
>
> I would like to queue them into sched/core after the merge window.

Acked-by: Vincent Guittot <vincent.guittot@linaro.org> for the serie
in addition to the reviewed-by for patch 4

>
>
> Also in:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/cleanup
>
> ---
>  include/linux/cleanup.h  |   5 +
>  include/linux/sched.h    |   4 +-
>  kernel/cgroup/cpuset.c   |   2 +-
>  kernel/kthread.c         |  15 +--
>  kernel/sched/core.c      | 327 ++++++++++++++++++-----------------------------
>  kernel/sched/deadline.c  |  20 +--
>  kernel/sched/ext.c       |  47 +++----
>  kernel/sched/fair.c      |  15 ++-
>  kernel/sched/idle.c      |   9 +-
>  kernel/sched/rt.c        |   7 +-
>  kernel/sched/sched.h     | 198 ++++++++++++++++++++--------
>  kernel/sched/stats.h     |   2 +-
>  kernel/sched/stop_task.c |   9 +-
>  kernel/sched/syscalls.c  |  84 ++++--------
>  14 files changed, 373 insertions(+), 371 deletions(-)
>
>
>
