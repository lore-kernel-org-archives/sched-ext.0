Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB80148AE32
	for <sched-ext@lists.linux.dev>; Tue,  5 May 2026 15:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777996701; cv=none; b=h10HIdnBryOkMNZk6fSbxNHDYyKv/ji2C5DmGXoDZ3vheqIp40UWHE74nRzX1gfWlANvj1ALfwxOD7XDPOxwx6PaGN6lDqFDCjM1n64U+cI5GxcnNJdCogcIVU9ezX2PyiILN4VfdLzCK24E5MIPEPoiFd8xxBXBQFuItpqK5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777996701; c=relaxed/simple;
	bh=q5u/UdHFSJSvCX3OoYzCme3wenzpAuPuauy9KaBJs0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AERzgz1TIEFhNMCI0stBOczf50qVTi/DBkMbNeUZ4xCzI6bzJCzi8no/h0f8mJTizM6M/wYI3jFYZQnV2WSlnyoLrrYLVBonrJyeYCbJVNiBL8fSNLIWWAYd0IgQZRClg/6+halJhmF+8WQll+CA6zwjdhja9I7Grnpzz+Z5G7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/iFiASM; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/iFiASM"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c80170db7d6so1078171a12.0
        for <sched-ext@lists.linux.dev>; Tue, 05 May 2026 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777996699; x=1778601499; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GFNz8igJVfgZfXbWHEAoaJ0onW3oZl+AuVGbjieeRbM=;
        b=I/iFiASMOLMD7jWnB3IaShw7LZ3u6r/qp2taKD8uM77wxGHne0KbT+2+RC9P6cGMhG
         ZJR6Z4qv9MRMogN+NN9sM+hv/ev4j7hwOcCWndrxHGjmjsYe8sSILZ9f9Ny8Y0NWiyke
         rpBTRtNI5a3y+XxFlLceOSPKKICePSv4IrlLQESKVqRt9pN8Tfg4d74yP0n1vxUedCHV
         GywNtaSiFnfEYMrr+zHgI+RXBEVAbfZu1SaDtutqrVvbS3uIakBSS+anqBHKHNHxsBZM
         fMoiTuueVozHy1ofcXSUKo3Hy3BWyGRCYIeQas9e/c20oMtFhsv8xxZbhqhefiDDYSHI
         M9eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777996699; x=1778601499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFNz8igJVfgZfXbWHEAoaJ0onW3oZl+AuVGbjieeRbM=;
        b=Un+PAU0Tc2VxujzPSqg+v5vKDyYEdXsv/8ZlRhWvaOsgtHPgONTV61b1Trn25/l8df
         1vK8mYFwt8D8UGbeB+fkiaIqAxZsfLlqGiPfd1Uh9lAbtGmfYsO2azkjL5+pRkJvrEM+
         h7y3aMqKyluYizcdb2RmEZ6rR9Grn2oxzl6fCsw0S1clhXWEzapWXfmp907aSAdkRKW8
         bDgqmmI5KBRfsQedlXlDO5yyfh66mmfjsRVpPtpEkKePXrz9ZwEEXgOiSwO8r1vnrXlo
         xPgrGG50f1XKnX/CZVem0+uHTIFIMeN0w8urew1WMeESKcPniIJuCP5rsHzPH8v0u3nD
         gRZw==
X-Forwarded-Encrypted: i=1; AFNElJ/4L7jdteTnD/oCFURCzCerwmNch8KCVkQ3Tw9hj8wLMhS/ojelA31t/O0DN9fcLzhOrAokyo93a6M=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz8FTDibZda5EBbgEhdb6tdDlgHqwrBoJtzQGtvxbgo46UCpQTf
	DuuvdDKT8j/QyMmpIqEChjtjWvn1fKfllbx8bWdTAjSm5Ol/hWkYcbao
X-Gm-Gg: AeBDiev+POFhEuwqeWCbHeOrJgobTetuFODeL5lC7mwx+h+dfTLo9IswPnAtRTaCpi8
	DhnbUBSjghmqQTF6zyNAiE0XXHWYAwsS28qWoghMKFbujEIx2UImORs9A522vUmPP5qfSWoFw5N
	idGo7/CU68Nwbu1ooJZLE16PAoyCSvzel+8tsJph+HJy2OucE+hzMgdzEKhQublFdpb3OImWybs
	oHwLc3uEObg3fRcvhejMUmKJrh5d5SwIt+5zW4lOPnGWsHUUmWtv6cAxySS1ct+fkjqmsxHnjia
	SFSOUXP6qP7KoKHxLbQZcMQbYF2U5yHd4gQnDIOja3w+UztR/WZ+qLfHH4w2nsK2Hl26vh/g0g+
	W6zu/FQ4h0A/3077iEv/LV2OSLnhSMRtdGzsplp8zXxwDKVW7f3FiEYvdjilfCgW5qF6X5zfvv9
	ho1yzig9C1RXkbwGBuHmtQ8fZLFfHuBAb1dxxplbPwV0+vgGYMaRLPWidaBfj603Ndkl39UqqO+
	fun0spclyWR/h99ObqvZorpEVA=
X-Received: by 2002:a05:6300:210e:b0:3a2:7ef4:81e1 with SMTP id adf61e73a8af0-3aa3b87f72amr4177149637.47.1777996698921;
        Tue, 05 May 2026 08:58:18 -0700 (PDT)
Received: from cchengyang.duckdns.org (36-225-109-31.dynamic-ip.hinet.net. [36.225.109.31])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbc6f84asm12360504a12.19.2026.05.05.08.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 08:58:18 -0700 (PDT)
Date: Tue, 5 May 2026 23:58:14 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Kuba Piecuch <jpiecuch@google.com>, Andrea Righi <arighi@nvidia.com>, 
	David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Christian Loehle <christian.loehle@arm.com>, 
	Daniel Hodges <hodgesd@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: Invalidate dispatch
 decisions on CPU affinity changes
Message-ID: <20260505234158.G1d71@cchengyang.duckdns.org>
References: <acHJED4iAeytdC2l@slm.duckdns.org>
 <20260422142633.G7180@cchengyang.duckdns.org>
 <DI0KLDKWJBOI.2LVQ249QGVJI8@google.com>
 <20260426093756.Gd781@cchengyang.duckdns.org>
 <DI3TFV6PNXZ7.3OR8GY5SBIEZ7@google.com>
 <20260502000039.Ga94c@cchengyang.duckdns.org>
 <DI9QFXIX3Z0R.23PU1FB6DEMPS@google.com>
 <afkOqQRB1YqSlL4x@slm.duckdns.org>
 <DIAL292DWST9.1UIAWWSHW1UMB@google.com>
 <afmq4DtGZcf4Zh5D@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afmq4DtGZcf4Zh5D@slm.duckdns.org>

Hi Tejun, Kuba, Andrea,

On Mon, May 04, 2026 at 10:31:28PM -1000, Tejun Heo wrote:
> > Could you elaborate a bit on what you mean by "properly synchronized" here?
> 
> If ops.dequeue() synchronizes with the dispatch path so that the task being
> dequeued is either dequeued or dispatched, there's nothing else to protect.
> If ops.dequeue() wins, the task won't be dispatched. If ops.dequeue() loses,
> the task should already be in either the dispatch buffer or local DSQ and
> the kernel dequeue code will shoot them down. In the former case, at the
> dispatch buffer flush time, the task would either be already dequeued or
> re-enqueued with a different qseq and ignored. In the latter,
> dispatch_dequeue() would remove it from the local DSQ.
> 
> > To me, introducing cookies is primarily about adding flexibility around
> > managing the "dispatch window" between the qseq being probed and the actual
> > dispatch attempt in finish_dispatch(). For example, a CPU can get a cookie and
> > pass it to another CPU to perform the dispatch, which is not possible with
> > the current interface.
> 
> So, this is mostly for schedulers that don't want to or for some reason
> can't implement proper synchronization between dequeue and dispatch paths. A
> convenient thing to make life a bit easier.

I think we are on the same page! I'd like to take ownership of the
cookie implementation.

Andrea, as we discussed offline, please feel free to send the deferred
SCX bandwidth implementation, since you're already working on that. I
want to focus on the cookie implementation first, since the design has
been discussed for a while and I want to move it forward.

Here's the API I'm planning to propose:

- u64 scx_bpf_task_get_cookie(struct task_struct *p)

   Returns an opaque cookie representing @p's current qseq. The caller
   can store this in a BPF map and pass it to another CPU.

- bool scx_bpf_dsq_insert_with_cookie(struct task_struct *p, u64 dsq_id,
  									  u64 enq_flags, u64 cookie)

   Like scx_bpf_dsq_insert() with slice=0, but uses @cookie's qseq
   instead of re-reading ops_state at insert time. A stale cookie causes
   finish_dispatch() to silently discard the dispatch, which is safe.

Will send a follow-up patch soon, thanks!

-- 
Cheers,
Cheng-Yang
