Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536682;
	b=HCO1TQwHH+ssxLTbmYKAxV+ba5M4wUS2aECPpUkkwIcBiUj469nqACI2Wfn9+trK8nig
	 s3ccjbrJoG1/Np5sc2sBH6rKMpbLE5psW0Kn+f8JPLKd1mP8Q/jpr2b+cVM+eHs4+vseq
	 p8k7ZnJFozSaC0m8x5sdaxiyxDErb5Q+eileSpsMVDvKu6+BihZJanCcZ1THG2+pq4+7B
	 XJJ36KnWo4cOfHHLQmxPyri9PaYJrAubXqlVbIOYNYNcBnQGD2R10kYQphmkTAVF6J35C
	 v5W/KAAZFx8SwsmZN7dCS5NgCbco4Y+sWSRmz2vtgj1UHhJ22ME50peZqU55dMxtADg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FC1Ad9FNE9LJrnknPfG7UGlh7vjFQN9q+d2pNc+QVWk=;
	b=yGpEmyJgF8msHdBBuQm1cWomuesEccI3k5oSSrs63iqGnK0rACWKiqHQ6kQDjFyAJ0tD
	 /WnLoUQNDdvFMSyhBd48dKx7MmmFvy3uyjjMR/rIOqcUQ2ZilTOOk47r1cDpagxyckhdm
	 ykln/CgC4BY+zPLiD0TpGWN5D3sTMiiaGerUuUTwQwkxwiMeXuD3SUW1bB9OSDtxFNqA6
	 vPkxrrbhIRPxwbLZnW9B8FwhjHxIU6VargOPeuHSgUoQfr/fn06dbBMJjVLL33gQxSzrM
	 SlJc5zjXL9FCHNwsUcsF5rlPW+j5KJa0fr3OCWMDzG1TlSV9QkKamma+U+SmhKS5JvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lzbp78wW;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F3F606A321
	for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 16:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63F3F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Lzbp78wW
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386c4d2e2ccso1289925eec.0
        for <sched-ext@lists.linux.dev>; Tue, 24 Nov 2026 08:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795536682; x=1796141482; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FC1Ad9FNE9LJrnknPfG7UGlh7vjFQN9q+d2pNc+QVWk=;
        b=Lzbp78wWujNRjAsLurb7QSgGa+6NCyub4Bv4AcI8ll4c1boH0d7U6XBhZ+hNNzWrXj
         xPNDM6d1LRw95NBz4Ld1hjpMvKroqECxp+X6wsnyxB78IMjxvIAI6o6T5RUFe636qCJy
         DGiv2wJzIUHH6lSSHHzUUweTN4UWV8RMhE9SnTRIEpfSHyQYEC1r6c8DZ4xWH0rD5GWE
         hj+TWVFjHgUrLfJk3WrD8EY2Ij9xe+SOVW7qcxYzcsh9aYoSBlzQC/Cl7Zt2VxxjNuo+
         F40KQpctCi2xWwBa1nWH8o82/+p++R042Tjc+hb3z3cUyHX2tz01lkbtomGkzr/O4hqY
         /p7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795536682; x=1796141482;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FC1Ad9FNE9LJrnknPfG7UGlh7vjFQN9q+d2pNc+QVWk=;
        b=Krp7QHy2Nt5pKYug9s1noi84KjL21iqoavkcSMz89t1cEn3kd4gvDAx1jPJXTvS0Hf
         ZF6cclXb0OPGGLbLxpJJ/rEjwjGbaJowFnJYObcYd+bwGiIdSGqh5vQ6Hr0khk5p4WD6
         /h/Q0tZuIJA/vQODlqlFWM52+An9NMEOe+UZdfD2DvHgs9bgIm+1KnhtfPJ2d/TVhihk
         czGZRihNJRWMCt1INZLYCLNsxoiux23n2SdnbJrbWgDxOjipuFLDZNf437k9O0cG/x+Z
         O9gLsl7ua4+jRMlXpvE/O60MUrqEX1Zb7h7LEVSX3XG46JzuUOy4T2ypOPiF1s+MPw0U
         mGgg==
X-Forwarded-Encrypted: i=1; AL+hErHgr7LGLPKrxJ4ST/X4eJxOQ3NzbU38fXtAvMRsdNV79q1CcFl/RO7xWIR1RqGcqynMQqlPtkVaW/E=@lists.linux.dev
X-Gm-Message-State: APuU4Z/qmwcWe1+Wh45KnKetTKBW3lP4ejiUTr2XP3+clf9Pva2AktWO
	FxfUCMgOJ/l6aihlkEZsvlbT3XWPs0eyiuNAeshPLXIxJM2KvE8wKF3U
X-Gm-Gg: AZFdTZdjaZrYifrTA7Qja3TOsMohI8n8UeYPPzjgVdFpFXjDOarrNmiy7HSlmdpdV76
	E3Cq/vY3bo56OiZ72CXthtE2DtfX101pj9R8uEmzj0sJ8i60qy6NbNCt5m4gTYJC5/zKwUrvSM0
	ObdeTUZfmQyOzSu7XuPlehpRXqoaMjYeUWARHScY8+Azt220cFZMpiDGPdFjxS4W/mQsue+Xm9R
	KnZGiWvvv1G+h3s0PI5LFJRJvvwkdEbkZ9y07s6tvmPKuCcSszsCm8g/33ajtU24wTOJcsjiTVP
	dPjXJHIJXfZPCOd3Jdr3l4F9yu05PlgZ+3acMoBaOkjdNAM0RwLSA3sWhvw/vUXH1kvsteKSZfo
	RjNLLREgb1iugN6PV/I9gymluUN6Aw2g50Tj4uYfIh2bb58dagh75qCOr1srKuzSYgjJHw9bGYs
	Wxmj79UkFpAL3PFdp7JibWxb7vyekNnH38QExUvSJkR8b7XCXSrKWAqjcMnztnzOAIo7kt6kGP4
	PdgGr8yGWqgyH4+iD466akeAiHw+vy53poNtV+zW2vD1/P93cfRSrUxTnqSGQb4vsrx5VUjOpE3
	DK0gjS2D0iK7wPPTy6NpzqS+osMSFtxotpAPpITEGfE83NeFph+IDQ==
X-Received: by 2002:a05:7301:6192:10b0:386:a7f2:88e2 with SMTP id 5a478bee46e88-386a7f28967mr8524445eec.23.1795536681241;
        Tue, 24 Nov 2026 08:11:21 -0800 (PST)
Received: from srsys1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-386aaae4960sm21043446eec.18.2026.11.24.08.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 08:11:20 -0800 (PST)
Date: Tue, 24 Nov 2026 16:11:16 +0000
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: reject oversized exit_dump_len
Message-ID: <awW3JGUuyom8oG04@srsys1>
References: <20261124100508.1060692-1-rhkrqnwk98@gmail.com>
 <07a90f0f36c010fffb626a80b6275772@kernel.org>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <07a90f0f36c010fffb626a80b6275772@kernel.org>

On Tue, Nov 24, 2026 at 04:05:29AM -1000, Tejun Heo wrote:
>Hello, Sechang.
>
>On Tue, Nov 24, 2026 at 10:05:03AM +0000, Sechang Lim wrote:
>>  	case offsetof(struct sched_ext_ops, exit_dump_len):
>> +		if (*(u32 *)(udata + moff) > INT_MAX)
>> +			return -E2BIG;
>>  		ops->exit_dump_len =
>>  			*(u32 *)(udata + moff) ?: SCX_EXIT_DUMP_DFL_LEN;
>
>Maybe read the field once into a local and test that?
>
>  	case offsetof(struct sched_ext_ops, exit_dump_len): {
>  		u32 dump_len = *(u32 *)(udata + moff);
>
>  		if (dump_len > INT_MAX)
>  			return -E2BIG;
>  		ops->exit_dump_len = dump_len ?: SCX_EXIT_DUMP_DFL_LEN;
>  		return 1;
>  	}
>

Sure, will do in v2.

Thanks,
Sechang
