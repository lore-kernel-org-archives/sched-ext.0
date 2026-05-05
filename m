Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC78F3D332B
	for <sched-ext@lists.linux.dev>; Tue,  5 May 2026 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777968122; cv=none; b=KEP3SjVYGI79Who6KZM8hTt3yevGYgNE/D+m/jDUzyhcm2t1X5EaV5QYvXCfsqDb8pvMh0e4y6elTfocerDQcCfK0N818sLDYWyfKyt1jzsD50LNFWvkDhGuTlZ/tKwiMPTZshet5pUkjwXEHQVDbtswVoxuKtTycJ5pwcQIsfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777968122; c=relaxed/simple;
	bh=NxwtX9irAEFeGS8HS5VT31YpTjN+TQ3bVZMKEVe1n3A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YMR/7IfaIK1es8mOwNogoxB1a5K3x+HddvK8uiI0hvPsnLHtgrKv6bR9xPN+XCqKtdxYeMy395e+kGhSapC7PDJCJg0tu6PcM2BBOxaRcAUAdgpmLrJgAOlLKgKTyKMcNHP9zZz8S108lLEIzbBYoKeuA3AYsZEe0qiGFjFN+2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPqwNYR9; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPqwNYR9"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-44a71109b94so3036924f8f.3
        for <sched-ext@lists.linux.dev>; Tue, 05 May 2026 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777968119; x=1778572919; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yKfTNSHVltU1PUFK1e+z00kOFW0Io0Jitydvnmi45+M=;
        b=BPqwNYR9IcSLM+FAilgrFKZVgFPrnW4kVnOqi/pMq0qgoMuWEURv+qms9tNc+9zebI
         rSNdLlSJv/IeE4IiBNFRfd6WSYFNq+Dne+qGOHFEBQlnVE6RL90AErKn8UHWvpXgGhub
         HJgQw7kDYY3b3qzkzvAUsB95Rl4vTegrP9SswTGeiRp17Vc6/I+05NP7Qufy0GjaRD+t
         CsgZR1WUO2U1gCdLahpL5UZ27sZkvUL1BRU4y2b2JAqGto0uIcthL9KjlbixClWNQOLW
         IhZfcIIv63zU1+z0UNLWSTr/GYhY16YXnmej4pMAIafQOYFX/QUImdtmV3QP2v6IXmIL
         czpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777968119; x=1778572919;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKfTNSHVltU1PUFK1e+z00kOFW0Io0Jitydvnmi45+M=;
        b=CvmdCgGTL95biSjXcOuwiCC+bbXVoj7Fm00zzSJuKKfCN+GoaQayVVyf4rA6oYNE3V
         kke7WKRzJXzrxPMAoJIjcpuwfnq8p41IWGRMcdJsPdfNDw5gEahOMXlxifXMkx79ymZD
         lD/LJ4knMcKSSK3yN8iTvPltpzsc4olI6NjRR4TZvMZNjImx31RftiBqIL5PXzmKS2QG
         DaxVyD5NVKqcu0g/qh811DkXJmv+ZNDHShnxjk9s3FwlAK3vP0zFQTEeysGiSjyaJU1X
         L7NM/HRQlYPEnyOq84w6Vsuh5Is+rpJibUqDrMaTB7r3qRD1aoEEEqzTDo83FvCHS++r
         gJxA==
X-Forwarded-Encrypted: i=1; AFNElJ8AXRXAdp9sRiI6B8d6vbqddjmEVddS5HEfZfkPKGH8sOJRK1JAZL+TPWfUsklpbeumKDmLKG9wvYw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy6FBtZn/QiugJicwWREXGOL7pWQ2dcSrFhvBoNS0vff47uTQDX
	j/JrL46f4kIXGJaGjY/GFpkzh/zT/HLw0jul/ri2S533n5/ZywBJH4/6LBU+bX676TCl8fhuVKP
	ZuAcqgLOJRf5Zow==
X-Received: from wrwb3.prod.google.com ([2002:a5d:6343:0:b0:44f:c72:611e])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4301:b0:43d:1dfe:350a with SMTP id ffacd0b85a97d-44bb66d4b36mr21738273f8f.22.1777968118914;
 Tue, 05 May 2026 01:01:58 -0700 (PDT)
Date: Tue, 05 May 2026 08:01:58 +0000
In-Reply-To: <afkOqQRB1YqSlL4x@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <DH6OUDJUQNA3.6L4YXJMME4KI@google.com> <abxl-xw7nt1jp5qT@gpd4>
 <DH7HWWN0HZQM.1ZSKEH89LMOKQ@google.com> <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org> <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
 <20260426093756.Gd781@cchengyang.duckdns.org> <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
 <20260502000039.Ga94c@cchengyang.duckdns.org> <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>
 <afkOqQRB1YqSlL4x@slm.duckdns.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DIAL292DWST9.1UIAWWSHW1UMB@google.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
From: Kuba Piecuch <jpiecuch@google.com>
To: Tejun Heo <tj@kernel.org>, Kuba Piecuch <jpiecuch@google.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, <sched-ext@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, 
	Chia-Ping Tsai <chia7712@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Tejun,

On Mon May 4, 2026 at 9:24 PM UTC, Tejun Heo wrote:
> On Mon, May 04, 2026 at 08:00:50AM +0000, Kuba Piecuch wrote:
>> Random thought: If exposing qseq values to BPF directly is undesirable, then
>> perhaps a less objectionable approach would be to expose them as opaque
>> cookie/token values? Same semantics, but fewer SCX internals leaking to BPF.
>
> Yeah, cookie sounds fine to me and let's clearly note that this is for
> schedulers that don't implement properly synchronized dequeue.

Could you elaborate a bit on what you mean by "properly synchronized" here?

To me, introducing cookies is primarily about adding flexibility around
managing the "dispatch window" between the qseq being probed and the actual
dispatch attempt in finish_dispatch(). For example, a CPU can get a cookie and
pass it to another CPU to perform the dispatch, which is not possible with
the current interface.

On another, slightly related note: I'm considering making scx_bpf_dsq_insert()
and other dispatch-related kfuncs that manipulate only CPU-local state
callable while holding BPF spinlocks. This is something that the comment above
scx_bpf_dsq_insert() explicitly mentions:

  This function doesn't have any locking restrictions and may be called under
  BPF locks (in the future when BPF introduces more flexible locking).

I'm not sure what "more flexible locking" means here, but this can be
accomplished by simply adding the kfuncs to the list of kfuncs callable under
spinlocks in the BPF verifier.

Are you aware of any previous work on this? Any pushback from BPF folks?

Thanks,
Kuba
