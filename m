Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519359;
	b=OmDnDYbk+Ju4Hc4zcppavAEDpQrWut1U8l3KNpG5lUSi/DAejNWjLZXG+DF3qoOTh0QH
	 +SYDzgxeEmjvShQ+BTn+WjLw7aOqSk78J8V0wv7hQuuIiGM2qc5/F5y9f+479Yv1U3El/
	 fShm7fieskUqggKXSFJBZ4gAfPhN7Bjmg5ET+nLF4+xHPyD6fwnIag6dpxG0PIc54ZdBL
	 8/UcbecCCiXXaXJVJ9gYYLxJrRz4BsfhtJEkninb30dNqb1SXg8OMPA/cmSw/unEVTVkY
	 31Z+yiLfVitBVYc0524EcStuvOB7+RepWOT6EhY27Wy4d7Qqy+ZtbKwXLXY3ELd6IOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519359;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=C8rpwcTwhR1wNZ4MDDmn36u6aY9QjfzBpyzkSNu0dN4=;
	b=xNa1SvBI62iS4b78HokfAAAnsRYISzEdFg6oVdtSLAmSk/aHn4Qlzmsp4oPX17k06Ggv
	 QUlFYRJr4AR92fkv7m02zxHMgYLgucVyLuES0V6AKdPyh9UugiPj7bSNa0WkqGqS7JE8O
	 AzvY9b0DSYcJk2w342rlH7H21eoz5Xwbc9AmVr/x+ShazCNlQdTlc/ynZkDTkqvG2QKDv
	 c/HxpiQ8zIkBN4kujUlnX2J/9+9OC+COCQY3pEKmwaxuhgWuGbdPWjScZ7bHh6xe4bU8L
	 fZrxN90xjopPRFDGE6CkobC9brMiBb5PyDFlqrrWjWlmAIFqMwRQeiqWH+a26etN/ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=j6srGwTV;
	arc=none smtp.remote-ip=209.85.128.69
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B67606A329
	for <sched-ext@lists.linux.dev>; Tue, 20 Oct 2026 18:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7B67606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=j6srGwTV
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a17741243eso21204705e9.0
        for <sched-ext@lists.linux.dev>; Tue, 20 Oct 2026 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792519357; x=1793124157; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C8rpwcTwhR1wNZ4MDDmn36u6aY9QjfzBpyzkSNu0dN4=;
        b=j6srGwTVIUf4X/6mJ8vbDrdjGqsyrFs3u/RaqahvtptFyQrd5iQQ1nsahx+6Y7ioGC
         p9FzOYo8wP6WvAm5Ju4Nt3jYHP10TwmgAANkCG74ZvE2PWn+N82V0oza+iMEIDzk3N5i
         cnTbwitotRlODeQEteBhr1/FkVJ9jqWatxjmrpeC8xK0FR/9IDejYuDnq7PfGE6wUKJF
         nP8N37oKttVXh9BV7ad1nuvMQVqJH3Eh0TuS6uah7d0Gjo1uAAtV7EGILb9qkkealNw+
         pLgo/Vcu/8D4jtBvQvqbHF92NTC9jMx7qDW4BVm1IaAg2txutgEKYtGRrXmE95p+mfFK
         dL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792519357; x=1793124157;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C8rpwcTwhR1wNZ4MDDmn36u6aY9QjfzBpyzkSNu0dN4=;
        b=OHvxVZh7XypEjgJ+7e3zqfy/l1nJ4XECe1fFNGgTS+V5q0Ej/APNdTZg3RsSnZWj5+
         5UB/CK5c4jjsC3S5CRdqQuswTHE9K7Bmm6JsTw14RE2zsb/0jzrfITvCt+ezKmWhKWCE
         xQZGSkMHaaYAfMIFnYzcaVaLPZFTQWeewTVYNYHw8jILY8sTxw66hcEpsBzNqHa49pnO
         cOQHi1rT41cX0/RRZCmcYdHuzPEuR5HrsoxG0i6f4eM517Gzta6E2O138AgiXPYYx4By
         RL8qMDdRXw7KkPdaZvgIB0FJaelywBJpNMMoU2FYsvly4rHLmxmjP9G2ZXNtE7hlUf64
         MWaA==
X-Forwarded-Encrypted: i=1; AKwUvByxsW9BaGau/gDr7TTJ66rGy1f87aanL5jOF32/C7T5jZIue8jEeqc7yBLkTExvwMGRzPYZe/ndJBg=@lists.linux.dev
X-Gm-Message-State: AFq9FYLh6HaKtupG6Ryj3fb7VrmDSe6D/o1chcubBg8gO22PO4T0bzNT
	rz/8k9aleQlpR4fuVaeuHNhmDbM29CdVbeabYnM0NS5mUfDi0DeK7dz0v+bXy7BQRwkwQDTq+Bv
	Xym8SFYiS2icqHA==
X-Received: from wmfv5.prod.google.com ([2002:a05:600c:15c5:b0:4a1:b6ba:c116])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6289:b0:4a1:dadf:9876 with SMTP id 5b1f17b1804b1-4a1dadf98d1mr226083295e9.23.1792519356899;
 Tue, 20 Oct 2026 11:02:36 -0700 (PDT)
Date: Tue, 20 Oct 2026 18:02:36 +0000
In-Reply-To: <657547efeaea54276c50a0c106399366@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <cover.1792248922.git.jpiecuch@google.com> <20261019144807.1207781-1-jpiecuch@google.com>
 <657547efeaea54276c50a0c106399366@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DM9V2QCIFVGI.3VSJXUCU94ICW@google.com>
Subject: Re: [RFC PATCH sched_ext/for-7.4 0/5] sched_ext: Make
 ops.cpu_acquire/release() reliable
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Tue Oct 20, 2026 at 12:31 AM UTC, Tejun Heo wrote:
> I don't really see a lot of utility in ops.cpu_acquire/release(). As it
> currently stands, it doesn't add anything that can't be covered by IMMED,

That's true if the only thing you do from ops.cpu_release() is
re-enqueue the local DSQ. It may not be true if you're trying to do
other things like e.g. kicking the sibling CPU in scx_pair.

Fixing ops.cpu_release() would let us get rid of the sched_switch hack
in scx_pair, which we know isn't perfect at detecting CPU preemption
by a higher sched_class.

> and given how asynchronous the events are, I'm not sure an edge-triggered
> view of CPU availability is particularly useful. IMMED works because it's
> something the kernel can check and enforce. If there are holes in it,
> let's plug them, but I don't think the holes justify keeping or updating
> ops.cpu_acquire/release().

ops.cpu_acquire() is synchronously invoked in the dispatch path, and
ops.cpu_release() would be invoked when the sched_class of rq->donor
goes above ext_sched_class, so either in __schedule() or when changing
the sched_class of a running task. It doesn't strike me as particularly
asynchronous.

Part of my motivation is Google's BPF schedulers, which are composed
of subschedulers, and we explicitly track which CPU is owned by which
subscheduler. Having a reliable CPU preemption callback would help with
porting them over to sched_ext.

> Can you please send the IMMED fixes separately?

Will do.

Thanks,
Kuba

