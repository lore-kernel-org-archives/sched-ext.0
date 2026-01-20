Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88EA1917CD
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 01:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768873941; cv=none; b=hpMIIm8Jqy7l/6sGa/QMh642hTbgDSHFjPC9hw9M4pQQUDn44EJ65UpNxTy+Xb9+gPlpJQ0y7AmxxScI/Mj1yj/h1bjpsdztdUi0vpFFKLDtIpCpkGxbb6LSSnBNQFQR65wNjbEHZnDoyQqZHmOof1gyNfSgs/DC7oyrQ/3F18Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768873941; c=relaxed/simple;
	bh=J/x/DUKp0CfBkYwahFzNB3tYZHi6PFizSyMc+JqQ2YA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q+uIKrAaCAa6EPQRe9JpkzKxHVdxPKCdfxp134xGSxqDLRrxJDxbF5LIpg9XmjEHbqweCA4gPqixnqIwiHym9A87kO08uQ79ONcns/EajYdQRAa2FvY3ZvHw9MqAIBECF4QjxWMfO16o/cH2IrWWyiTvyko4sSGNwe84k2CGSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMRsRMCR; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMRsRMCR"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ae38f81be1so5485602eec.0
        for <sched-ext@lists.linux.dev>; Mon, 19 Jan 2026 17:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768873939; x=1769478739; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J/x/DUKp0CfBkYwahFzNB3tYZHi6PFizSyMc+JqQ2YA=;
        b=UMRsRMCRCoza0oN4yXhyMwmc1BZtuCZs4mrywrwkED/mpeyPLuvqtZ3Wu4+BlJRX1c
         w8LQj/9irhD4u/LIUbgtldSWRRoXNhUQRHntCuJDzepsjbkRsrQ4xXeDdxs0AfipI+EO
         OO3Hvkq998nAvSCBY2p4x4g8o5+0irVAhFSt855rgWdI6dBMpKkipWixe6JGoojJySt+
         rqGt1KsowFSnmd8YNk6rjMcfybD5rlyKCFn7jHoJajTUGA6bbPW2JLzR1igINqK/O+54
         aGdxKwb2cndV14Hn15reJtrwKC3FzxJ2kT8PZgxdrPG8KlBouhZ3NJfpz0Xkyi2hqiMT
         09Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768873939; x=1769478739;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J/x/DUKp0CfBkYwahFzNB3tYZHi6PFizSyMc+JqQ2YA=;
        b=pM2v5I+RElr8P8wa9gSK1MwMSVzOPrybOGoO+XFwA4SN2kj17mIrdIqesJ1c5wUcHz
         LBjMCodxBUEaDqFBF+r2XZS0MM9bDPdZvRYUYOYh2czGcOAiyJFP4SFEEY+2LTG4fNEW
         3vXYoQDYfSy6kD/rIgkd5xEZYjkpHlVmbKySvJMVLA+KWtXmsRuVFLdg5bdlMMD+kwQ9
         zp9x0UlcE4xaWgEmCAnedEyv0K96L7lDUumYMrGJA5u7Aio537dXzRQL7Y4EPCLLvknO
         GkRM7pg5zMsfgKzRWgY7wYgWVVaYVPLnlXbSm17Asn7aoK8xnJvVgUFfWgV1X1ehTrnm
         Dyhg==
X-Forwarded-Encrypted: i=1; AJvYcCW9jUXUfHQWbz9zW8F/+x4hbP8m1Bx3W8np6C8ERdBi5DUwvzNze/+jk9vCBEpxHOxZz6I0TQo8JKg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxPkEFKl+8oCpyV0HDR2j3V+J5H2MQYOqIFjbbn4tU6ya7LbWlL
	OCR5xEa2hMmFXTs5CiS0EBjHhn1NsvOnT1Tm9ovikJdmdQ8E0vdePasV
X-Gm-Gg: AZuq6aL3V1TveUSGsgFgdAjsousrteAP7fr1nxa+VgrZ3OlNhbyQe1QycXgA/uRxl3T
	78i/CATYFiDIoT+pEOXMTWMt6lxzRATwE7V9o8zrTz1fhl7VLbQ99Cj6lSL966ES6cT6aypuYcz
	5AU2zUd/15sWrwTAvR2jjRhJ4YZQbu1DCtBFpgiQ5iSOd/3kNNtSKnYIv5VvWx9U/xFHE9qjYfb
	VeXPhT7XX/oA2rNhLSvEl7JpHe1ySB6sWaNuvpEAyCy9SXU7RP+1hA0oexL91IYHbDdzeSndKnN
	l2/2RAMKU5vwDKny3ZTrihRa0LPkPHTsC/ZccFyvjwKfxkckcRYkDXxaAUatja6sTIns9Z/bkNU
	GVlc8riqogHMVuo4ASuA5cAtXkk7l8y7fGzgu1hSxvEB7EdkOE1obWDvD71eDayqRqhhNgpBlPr
	6xHcvk2ERLXnMHMYuMhZcAorO/zAtSOl1aEmwgFJ8TzMBBixr7gq8Sh4QELBx0E39lGw==
X-Received: by 2002:a05:7301:290a:b0:2ae:60fd:6f18 with SMTP id 5a478bee46e88-2b6b4e8a496mr11469646eec.22.1768873939061;
        Mon, 19 Jan 2026 17:52:19 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:4cd6:17bf:3333:255f? ([2620:10d:c090:500::aa81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b34c11c4sm15186383eec.1.2026.01.19.17.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 17:52:18 -0800 (PST)
Message-ID: <d433f40bc631b456cf2ab44fd2ffcfc2c1193e20.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 09/13] bpf: Migrate bpf_task_work_schedule_*
 kfuncs to KF_IMPLICIT_ARGS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>, Alan
 Maguire <alan.maguire@oracle.com>, Benjamin Tissoires <bentiss@kernel.org>,
 Jiri Kosina	 <jikos@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 bpf@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, 	sched-ext@lists.linux.dev
Date: Mon, 19 Jan 2026 17:52:16 -0800
In-Reply-To: <20260116201700.864797-10-ihor.solodrai@linux.dev>
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
	 <20260116201700.864797-10-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> Implement bpf_task_work_schedule_* with an implicit bpf_prog_aux
> argument, and remove corresponding _impl funcs from the kernel.
>=20
> Update special kfunc checks in the verifier accordingly.
>=20
> Update the selftests to use the new API with implicit argument.
>=20
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>
