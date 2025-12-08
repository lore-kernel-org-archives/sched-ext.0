Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7821D3D6
	for <sched-ext@lists.linux.dev>; Mon,  8 Dec 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765192519; cv=none; b=aEHlrQ9qVSh8uOyMuvY+BbuQ5rA8v/MdW1I2Jn5eTi0mwBx8B2gj1vLYKT/S0ckSpng/1FU59u73dRr+UoOrfivXzgUjf6+h4Uq7+jVTsGXGisXf9SMFm+5BkdAEygNJAAfyJPXsCUSXg6TpUfOEN3SxCpVmyl+RuDhpF/mCtJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765192519; c=relaxed/simple;
	bh=sj7sNphhYZaVF5qP7MRJ+wFIXaN25bN/qgpFeh/bFkA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Q+AHTovFsPvzhh1WMza4xYUAqVn08187Fo8K/gRNxYJ43Xb47QeLPyMaKUe9U/5MWTm+JLbNe31FF6W2OLY0QDC6ZYRNfRjR6oaWwB+Sxof/KwTKAR9fAQ3QgYqPGeVwoLB7rcLJ8bEarCIHMnv/KavzyL2Rf2EqorrW8WXYSl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lueurns3; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lueurns3"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so33481245e9.1
        for <sched-ext@lists.linux.dev>; Mon, 08 Dec 2025 03:15:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765192515; x=1765797315; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sj7sNphhYZaVF5qP7MRJ+wFIXaN25bN/qgpFeh/bFkA=;
        b=Lueurns377RC1u0NUgWABIxgq/nUToH4GdcYDDX2sG03Hd/WcBZ+nKAE8bY0BFY2fM
         7BwjZp57OAJk4DNawBiBaejhoLg+VfSRpTbN5jg3BKrolGK27xCdAmwSMbBh+RxxPgHb
         nALtbiaoWlOeBNl21vxCySN+QbTKNzyWyoGwwNSl5OmKzDosfnghmtoIQCQ+3htrzHMO
         wDRpYcWkU9yegeFl2A5xWs4EH+atjKyhJnC9HSOGApx2FZYknNJfDBWPg2V6ra+r7mvQ
         IP38vQ/9T0XKaELnd4Ce4tC/YZBJi5stDj0OlMgZ83Bbkhkq9Zxedipkpm7HyOc6v4vt
         ABog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765192515; x=1765797315;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sj7sNphhYZaVF5qP7MRJ+wFIXaN25bN/qgpFeh/bFkA=;
        b=PPhWVyFi8H+jYS6N80ZXPbmrQLbA7Y3jZnxwAJAYI8PcQqoeS/I29wGIKbULUZHA3J
         bpazzstLURsJSsPkrBOMC8AamMvvMGIDecY7vznFNjcI7n5T9lZmtXUcn0wICEclEhjh
         UPH1IBeGZWcEmbqJtVQVYytxNJXq04vx9fyKBWYpPGvepaM/5ESneQLGntDZzQMsw+uq
         449XE6lE/+Xu1jOxR6TOzUa+PYg//2oszlU22Vuud5r6oHBI9FHQxypsUv3ivuO7G+zj
         rirjZUYuwQ4BFEK2K6c20ZxOF547FllD8XsppR3qSQRT/7oSNSVc+wHILmMDTItLqTSR
         0DaA==
X-Forwarded-Encrypted: i=1; AJvYcCXYEx8aQ0JxI4FS/bY0nQT/GyWjirJsN0HgpyJdmsGqLm5RZl8aX+1pmY37LlrMdTPFh+N3V6uc+6I=@lists.linux.dev
X-Gm-Message-State: AOJu0YyXf1FzxAR9UK8bn300G8E5KbZptw2yiRy2Q19tv9NHkpYYuhH7
	axfxMcg8wtPEgwAkcDZi2487F1JG1BGTT3NbBhuCfkTGgB+my8ATVtKjm7praRcPXnRbuchTdEl
	gNbrsVFUnXBqQug==
X-Google-Smtp-Source: AGHT+IHgil5oa21F4CeSi52vizMTZQ9YndgxtOBxLFoV0jCWSTP89KlmMN4RCZcHpaF+jM9XC0kYM0SuwxPNlA==
X-Received: from wmma16.prod.google.com ([2002:a05:600c:2250:b0:475:d94e:4d5d])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fd6:b0:479:3876:22a8 with SMTP id 5b1f17b1804b1-47939e1deacmr81009055e9.16.1765192514810;
 Mon, 08 Dec 2025 03:15:14 -0800 (PST)
Date: Mon, 08 Dec 2025 11:15:14 +0000
In-Reply-To: <DESR4ZKLE36H.3MT2T8V3VLV7U@google.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20251206022218.1541878-1-jstultz@google.com> <DESR4ZKLE36H.3MT2T8V3VLV7U@google.com>
X-Mailer: aerc 0.20.1
Message-ID: <DESSIU61C2DE.1R156AQCNP80C@google.com>
Subject: Re: [RFC][PATCH] sched/ext: Avoid null ptr traversal when
 ->put_prev_task() is called with NULL next
From: Kuba Piecuch <jpiecuch@google.com>
To: Kuba Piecuch <jpiecuch@google.com>, John Stultz <jstultz@google.com>, 
	LKML <linux-kernel@vger.kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider <vschneid@redhat.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kuyo chang <kuyo.chang@mediatek.com>, 
	hupu <hupu.gm@gmail.com>, Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, <sched-ext@lists.linux.dev>, 
	<kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"

On Mon Dec 8, 2025 at 10:10 AM UTC, Kuba Piecuch wrote:
> It looks like it's impossible for an outside observer holding a CPU's rq lock
> to observe a task that is running on that CPU and isn't queued, i.e.
> 'running' implies 'queued' (I'm new to the scheduler so I may be wrong here).

A task that blocks in __schedule() can drop the rq lock while picking the next
task, which is after try_to_block_task() dequeues prev. So it's very much
possible for a task on another CPU to grab the rq lock and observe prev as
dequeued but still running.

