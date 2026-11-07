Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794034408;
	b=CwBoJbTgzoiMks08NYB7LH2AbnTc5e6ejb55ZLYzSBF2sZ028jWCNX3TSyHZbHiusdff
	 bJ/S/1MNUW0YQj6UcEdjs7uM0s3PJwHleaGsSwLk3UIw1N3q4YidOyPDTDHWTxpvg9Psr
	 u1SfF+57utBwcLu+81XnjB9Jll2FmeneXHCerX0jQY9u+Fl+vf5hmsqMch6fAyDBMRNgz
	 M+Bwqhm8+t6YeJteWbobeJx0ACOGY0TlkiTYh+ikW5OVLpomCSjLShUkZOoKrL4oP1arl
	 OZplZcZPwXqozGFCGYE4qrL78UZcFpN1xtxL7+1FRZy5QhsRvdYk7JXvHf9oQ6qD+YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794034408;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Eto4368JR2hmRW7wKGSiDlCRlUrolYOPtl6iuMGKc+w=;
	b=J3w4e0MGd1P6ETUDE05+H3bGHapNV+xBFDCaE8JjymR4rVBcHvQ+zIjJOz36uXL9W2yB
	 VEuq1+PQT9kTFNntSlb0sbxfFjEAPdVQKFv0FXJWZRbTmEZxFcnM14XtG4QrESUN7xbu5
	 eXOsXA3mSA9R6y39E9pFpLQ5Rap4TaLnDX2fMNxaKc2oS8ABQc8GGeT+uSZ9exQhsqrlu
	 dmbtHu0bINcmsCyopkzGaFdIiK2y6hxI38r9C10sKZKOYbU5YB67cxV8HmE/yNPGB+CEP
	 x4AUvNOJoxkBcrZnvvY2o+ziA9DGvbldp2KQGyuTit/wpEZnYYu2hkNFaetlob60csA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YGs2UXCB;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FF2606A326
	for <sched-ext@lists.linux.dev>; Sat,  7 Nov 2026 06:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40FF2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YGs2UXCB
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48df4f7ccf4so47451f8f.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 22:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794034407; x=1794639207; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Eto4368JR2hmRW7wKGSiDlCRlUrolYOPtl6iuMGKc+w=;
        b=YGs2UXCBvQ0SvrOi+gFPyztC75bx0w3dVZZBEQVCYr4YezhBs5PdL4eCqbnpCUrSaz
         BEG05+Ug448MZf+BIz2814jTsdQOTb/Tzd11Sk2m/COdK35uAsMAEvxwPk7btcSgLZbG
         O/QRf5fq2iGteHuixCJsmzGtHwNYfwq3Aew/O9oP6xhFeT4ttfxQGiOaqoRfGESCO+4Y
         9sN9/zzspUcne5ufKud9UGlPVUjzDKcbuLlIEG1sB3GsFyxoIdaXdFKV1PIqR0+2VT0u
         h5XN2tpWyYi8k8vLOc23t1KMSHkVkiu9xtUVUrG5FnusrFUenKPOB1xj1U6Ys56j2U01
         Zs3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794034407; x=1794639207;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Eto4368JR2hmRW7wKGSiDlCRlUrolYOPtl6iuMGKc+w=;
        b=jBGSsZxALHogH952pf9hIahtm0HWsiqYp02LOLL8Uak70fyaQuU24iTkWX9e28Qm/m
         VBxMlmJCXZlS/NXpqUOh82GCDNBpcNRMoLRiPLVYJCJX4dsUEXGasIGCajC1qY+IHcrd
         YPVu75NF9O+2tM9suZXm10U8JsW0RxVYjsO3hdxdWbR8f7vbaq2JUYPO16+lGou6i+Ek
         IeTllOXB80ODMrK3IIYNUd2cWYfBWZ9WYJg1mfS0ZvFHAKU1XCKKktSqfmbUacsDCOfr
         ZnXtcEk2KoVq/pKWaj3fm/x8JM1Vwf4H+s5S0ysnGOiGJo+9sJzgrmkuPncxKzP9aikb
         71Bg==
X-Forwarded-Encrypted: i=1; AL+hErFHoQVDDrSs2cJRYgPENPmg2vVDx8Y7QjN1snzBP/I0KZSjwoe5oWjcTDHX5gNbtja7lIUZ5WuTg6Q=@lists.linux.dev
X-Gm-Message-State: APuU4Z9o0Ui6Ff+iEraSMV41n1eKKOn7o0vZJOm/oXtqcxNHZFp1oq02
	7WN+G8qCdCCP4BAzTeZT7NufvOwOHmtaXMsdhHI3dju5CP6bZiTiCxSZ
X-Gm-Gg: AYBFou0R5pAje6Et7t+XjSakW4NOAImj3h0lO09h+peG49n2UsxIjretnlozbBKa/6F
	1ahQdDz+gpFMJqekltbhpXuxdOIPCytO+EJvXe5imD9a8dY8I3oRzC1pSLrLSSKU7QjAfexnPRe
	8MQCHrTOBRnVlF88G6STNzAPykOBtBhE91b2A14n4UOoM2PCH6qinKW5MUReKbf/QOFciCvbtRo
	iZiX5qNL2Wd5SKW2DIXu6tL4zzzHTnX+VSSOKYtnl9V/6nJsofCO9X6FzaBPOVOs9UIoRKx7RXc
	Ohtq5ex/hQhNaYAVrjNZ9XOme1wHMu8063fP+3tMQvW6F36s7iWlWELV8iPVibXh71xnbmMqPpN
	VEq06E8nTEzLDK/0RmFbiXLOWwPBLZDmi08meEFCNoG2Vb2MwwpzyaHmMWIftEddg2fy1fx/ERZ
	9MnbM1RkMcGb4NXgE0ikysJbtx7RIgjQEj4XAMtG1dCe0UnQK6mc8G4c8In3xQiseo+HySQUvva
	oMdgMjCqJPmZx0aBr/WLGJ73ZNG0SAuQ1rrJ7tb5KsU2XDl9GQS8vwZP4HAoou5vDCNVNrGfQPm
	PliXzJASLhezKUtVcsgfCgmF2vm3oKoCRuUITvqYzcJinLijuB5oo2s=
X-Received: by 2002:a5d:5a45:0:b0:493:9233:ce65 with SMTP id ffacd0b85a97d-4939233ce93mr3783631f8f.0.1794034406420;
        Fri, 06 Nov 2026 22:53:26 -0800 (PST)
Received: from scheduler.schedules ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d837e3f5sm8000337f8f.56.2026.11.06.22.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 22:53:25 -0800 (PST)
Date: Sat, 7 Nov 2026 09:53:22 +0300
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	vschneid@redhat.com, kprateek.nayak@amd.com, linux-kernel@vger.kernel.org, 
	lukasz.luba@arm.com, rafael@kernel.org, linux-pm@vger.kernel.org, tj@kernel.org, 
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, 
	sched-ext@lists.linux.dev, qyousef@layalina.io, christian.loehle@arm.com, 
	pierre.gondois@arm.com, sshegde@linux.ibm.com, tim.c.chen@linux.intel.com
Subject: Re: [PATCH 05/20 v3] sched/eevdf: Add per cpu cached min_slice
Message-ID: <au4i4IWFvJw-7Q0Q@scheduler.schedules>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
 <20261106151947.3991524-6-vincent.guittot@linaro.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261106151947.3991524-6-vincent.guittot@linaro.org>

On Fri, Nov 06, 2026 at 04:19:32PM +0100, Vincent Guittot wrote:
> In order to use min_slice during CPU selection, update a cached value when
> needed after en/dequeing a new task. This cached value includes current
> task.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/core.c  |  1 +
>  kernel/sched/fair.c  | 28 ++++++++++++++++++++++++++++
>  kernel/sched/sched.h |  1 +
>  3 files changed, 30 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d7c3b43158de..031efe7d49fb 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -9012,6 +9012,7 @@ void __init sched_init(void)
>  		rq->sd = NULL;
>  		rq->rd = NULL;
>  		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
> +		rq->min_slice = ULONG_MAX;

This is already getting changed to 0 in 6/20, instead of changing there,
wouldn't it be better if we changed it here from the start?

Aside from that,

Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
