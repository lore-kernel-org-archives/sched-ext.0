Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795530994;
	b=aZUAd6dOuQ0B1+1uADO3vJmV7iWrBNCUJTTU0hlqGdNyD8Rs1KjPoscLwRaedk5nDn/Q
	 ZltA0hppcSuaj+jGgbu+HninfXtMBl+Qn1cxemOOrWmmaiiqpiVPvfn5oPBXfVn6F4nMR
	 wZiC1dxFhMbb5/Ohf/S4gqoTQiMrnXFuTEOX8K6g0FmYv5l4spJxmo/d7PyKIyv78bAq0
	 69QV9SraDlocKxSguKgTTvCoBevN/esuGp6iNUNft43rYtB8hmuRq/WxjFOYuFLFpZgIH
	 iAGbXzOsqJM1v2bACKApxMnOBU+sCSKqnLJ3UiPvbSjm8m2146NEu/1sLs68PSWkrAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795530994;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=h2mPSw1B7T+UpRiyzIuukEUJ/+X1wVAS23+YiwuYWu4=;
	b=Zrws0V27LPUX9NTucVusw32a/QHSP1hfJJ6D1x0XwZpNCJuWgF+uVNsqH1anZ0G7O86m
	 lYPUtlR8FBr5YgOcRado0kbz6F5Z3ph2J8EfYxzsLr88hLR3ZuSRGxAdd+wpVrFcHGnit
	 YctTM/v1lCkWcVpKqxP14TcWY5HkQ+82dMtIsV/+eoOKXDaEgxM+Bxc+CCdbb8+HCEXgn
	 hymbz9YiroN5mW+hD0tf9QH1JaEJ5aK2gAvpIGS8wxPexafIyaw1B/4livDVkiORKBhjc
	 N8FIos3Tb4SvnsavCM6srUzEBpg2xZrBYwJ7k7W5VnxA9OjSMTJb9z8fiqR0BsqBCuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oyGUHv88;
	arc=none smtp.remote-ip=74.125.82.199
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68596606A31E
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 14:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68596606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--penghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=oyGUHv88
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-341eff9e381so7379614eec.1
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 06:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795530993; x=1796135793; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h2mPSw1B7T+UpRiyzIuukEUJ/+X1wVAS23+YiwuYWu4=;
        b=oyGUHv88ph9qwOnmFvjezL3mY1iN6tiTE3Cbi7vRBmPgY2OlHUdXEqRA7kDFjzXdQ/
         jqbQKIUolh0Bk8PEauldxJjFHQQFRyPsN1ZgUh5wxZHBSbknBgC5InqBDFUwS0fXfqhx
         ltfwZsRmCIQhA1MUuPGwSB8LSeVxKRHoMS9kEazgaE02Nwc6mCuGxgRoUwt08fszQUDT
         t6paJ5U97J9pib19+qAJGZPg+rkvzuUlQ+KMTNoewef7VQb+Vgq+5DUvbHwG/ViClTSr
         6CHPWROGyC1Ymy526oyMPSsz6rSEfYAiEQRrPFph9a/8C0iJRdAuKaHaUKCD2ltPeUVZ
         F64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795530993; x=1796135793;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h2mPSw1B7T+UpRiyzIuukEUJ/+X1wVAS23+YiwuYWu4=;
        b=2mGjv3Lykkx8aWEz+Qgwq0XgOtq2wPvJjspwTTz4s5k2o/8zL7e8Ne7bRJyCzSz1lL
         sJKvjXeJBI6WSlyfvQCL+CQ5QAAWyJ87lJM/qjNNc/LXOxLrRDfT34nwCL2qT9JeRlRF
         qMTkKlBDcKIP7GdkUkdIoKDkEdhZS6erMJ+sMsKkHmia06KR7sOvBzw2sRlSoZ7MhkGu
         QEZdTJmqXtrWC+ZawOt+AH2KvkP98vaCIS2qCSFtJRW+8WMh7qcV5W3u8GiqltpEZoXi
         DYyl8vikHFn1iRNXk85vgGHTicBmaQ2+0a+ELQSMkZRYLGTZK8BwYcczUo715DQOuD8L
         Tw3Q==
X-Forwarded-Encrypted: i=1; AL+hErEcTapUQT442+12qcftb1gpitAldB6I3l9oBM9TXhpC4fAj5/7Le/AeMj0Oyk4yghPBaHnSk+zb928=@lists.linux.dev
X-Gm-Message-State: APuU4Z/+7wQ5cZu5MVX0noc3knt3uR5P9NT3Kht0mqJAOF+OF5tLnTba
	Slrvt9m8wtNt1ptvvPO46GxwC8CQzBPigcF88p2pjAQljpRsq6CNucxk36Vbuq5XH+bNngHcSoR
	5fWzzHoQnW7DZ6QbMdA==
X-Received: from dyah11-n2.prod.google.com ([2002:a05:693c:83cb:20b0:386:458d:ba4c])
 (user=penghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7301:211a:b0:373:5561:8d06 with SMTP id 5a478bee46e88-38570c36e7cmr13603125eec.37.1795530992365;
 Tue, 24 Nov 2026 06:36:32 -0800 (PST)
Date: Tue, 24 Nov 2026 06:36:31 -0800
In-Reply-To: <CAKfTPtDb6CZ8WyN8rdK_-9RNhaFRxaZGOE3+EfbkReqkFCCy2g@mail.gmail.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261122015729.2512645-1-penghuang@google.com>
 <cover.1795462673.git.penghuang@google.com> <9b14aecb0ad560a3ce5f7925aaaee6e4f4a1a760.1795462673.git.penghuang@google.com>
 <CAKfTPtDb6CZ8WyN8rdK_-9RNhaFRxaZGOE3+EfbkReqkFCCy2g@mail.gmail.com>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
Message-ID: <20261124143631.4012300-1-penghuang@google.com>
Subject: Re: [PATCH v2 1/2] sched/fair: Clear residual sums on zero task-group
 avg propagation
From: Peng Huang <penghuang@google.com>
To: Vincent Guittot <vincent.guittot@linaro.org>, Tejun Heo <tj@kernel.org>
Cc: Peng Huang <penghuang@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vincent, Tejun,

On Tue, Nov 24, 2026 at 11:23:03AM +0100, Vincent Guittot wrote:
> When fair tasks are involved, the next decays will clear the *_sum
> anyway so I suggest to skip this patch if it's not needed for
> scx_switched_all() case

Agreed -- let's drop patch 1/2 since it is not needed for
scx_switched_all().

Tejun, patch 2/2 applies cleanly on its own with Vincent's Reviewed-by
if you'd like to pick it up directly; please let me know if you prefer a
standalone v3 instead.

Thanks,
Peng
