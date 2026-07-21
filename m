Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8842BEA0
	for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 07:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617554; cv=pass; b=rjYLkxy8AzsSMazrCNplWXRzY438TWwIPc+jQ3imhp70591Ysr2QtkTE4EjTTtABvqpIsj5VWmGrtCBuoCxL5oCFN2D6nVrysP8WmhhregngGA0hqAkpnS59zW1c7WyTXwNtT9l7Czzfhe+OxgdTA2szEplr2lD/9VhXXQMf1fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617554; c=relaxed/simple;
	bh=AELB8Gv/075QrrlaSedBhRZvmYOLrqCEZxITUdZ82FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YSSHES2wpbtmfsZCLRnY2bCKwgaphGb5wYLLULzU+LPRP23Q/lbyBl1SNwl30DYx1NuYvsL4S563S2/6JRTaVidRAVb09ZlcuCIZtg9pyBZNq116VtdTzx24wY7x2TXeV4msdmFIqSA+lgJKWOpT8Ie8V0LH3iUB5ubhQDahLW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qfwUWOYw; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qfwUWOYw"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38101f85591so3788152a91.1
        for <sched-ext@lists.linux.dev>; Tue, 21 Jul 2026 00:05:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784617551; cv=none;
        d=google.com; s=arc-20260327;
        b=iV4axI7QesS0mC3SO1tMFsjiuG6Hp70EseI4wRl+NDv7KtjLG/dXaUPnlgOXFZUhFp
         3tgp3Aa/YcZQv9E4EUWNmokh6AqfteBF1xRFr5hf5rVczjDXyykArE9+rqRNVjPZPY29
         MlJpWc/JF5XHg8eH29WANWyRKZjM6Pzb9+qGCjf23m8NjbATAMMJ7C84WF/ZEEgx5WZ9
         rWK3ksYlBfYULtx9xSb/eCnlKoZ+Vej1cdIgYVsa4eGAUOoJoL7Sa84iiN6mstzykdw1
         C073TCwtkK61X8XJ2k7tf/F7DEix3pc+MgcR5CYm4pGsvcboE5RmDAORIg4R9XzRabhJ
         Mirg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AELB8Gv/075QrrlaSedBhRZvmYOLrqCEZxITUdZ82FI=;
        fh=tHWo/zxxIx8bpxZLAa6JWkJiOlcGzHOsR2zBsBM5gLc=;
        b=TX1MtG19Jk5hhQrfhrhOjB8Z5SLsy5HvfXzqKr/RiIcKCYTT+Y/LHQjjFtiRubPofh
         CTMmqwbPiPvvIi8YzKbfIrD+D+1dcFK2vxNRDXO5ClsKj8dFmrqR3YOPlF0/kyufcRp9
         HGEJqUEfmvvAQEeiTxvOmuAiLo04xrSUlX6gHyVu158JiRmcxHYTp36AVKNF7O5MbYiY
         u1OCOrddFczCeCkockymvefqYBhq+JjAlzexTsWqn050KSOOYRqdy4aSKKSY3tj4HMqn
         dD2wBlej30EDqDtKbvw7fKsJO8XwIZZpDxuR45CcGfwfZ/fqwFsOsP/S6WWcDj894IEM
         kMLA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784617551; x=1785222351; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AELB8Gv/075QrrlaSedBhRZvmYOLrqCEZxITUdZ82FI=;
        b=qfwUWOYwat516TcYYFT0rXX+ZxkteGgg/+HJIkzFg9mWyE8PLtYd8Q6+3NRVLElWtx
         ljMb7vw9W3PidUkpj/ns2wcWuqsd0ytLvrlLIZ04wYu4UN1Gs3KZh4r+65Mt4nKc7OGI
         BCynx5xSJX2i7U5ED6XhMyF1G+XRERRVMnIb4rScFqZQ7Psm3Ppil01nYbxWV8MXilDC
         ItEdtk8URV8JRZcgxIZPWeyiEkBQVRXpvaOMggFFaA0++sBzZdMf325MI9qU294r+TMm
         1gfPDsBfx9E6LWl+CZrnAVtIpmI7ErYgOPTuqhGwtLWcIiSjLsZYnV4GPOQ7AxackcWL
         TeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784617551; x=1785222351;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AELB8Gv/075QrrlaSedBhRZvmYOLrqCEZxITUdZ82FI=;
        b=tPr2MDxyFzTqGluidZASzv6hFdPQi/IdvNVpWxum+9/xyzm9Vr20v41nkogAlXnlS/
         uAVespjGqBSoBV1SgMS23CquBnavQ9yPIRJpJhto8volNfyHGY9jHwIa5rjYN+OJYMcl
         +TtXhCOn7QEtmjWt/7vBvv8EWNxDWEJ5iHr/9v8MHgUdNjs4qqEhkrhT38bhQTdGzEsH
         +WJ4Gu7L3wkApR5kc5TJko0DuSrQXRyWp7hKW+gZqBMI2fHV54umLZEFqHl28dHuX+pF
         5p3yIfOrKTr8dEJfW1S96IT8MUTNDZKE4MAjWEli1TkolEex8qLRgGpzuyonh5HRqRTh
         QwTg==
X-Forwarded-Encrypted: i=1; AHgh+RoIjV46XoYPxkMF6ENwZkZpdWtVKs4+sKuxvzL2GN+eOFICe2kG0ih+2u66BlXUiaATq8FZr22fQuQ=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJ4R6BwyZ/2+zQP3+mWPPyQn1KmndNxukxk4PusxUxKzXxQHKb
	xLJguCxcbjW653yA5ySc8bYr9MU2STiEjmqgT1V+3dvup592OmDYB9krzJI67DRP4IZkCwnI5CS
	DpK2z7FUCtA9jlpJ6+9xc/jU5X7uQ5rUbWnMO5Pw=
X-Gm-Gg: AR+sD12I3EwHI8/3u4xDDycnHHDAp4+BUQCPHodGyMZx0Pr2WdAszpCbjbgZAwyKMuB
	ira6qjMOSB1s1u9s6sN+6i0lNIN7PnLS+0h6NaljjCzH684FV1tbwa73gJAt0eICCYzHDTKeYR+
	/8mdbwLlg/HoaxOH1nuGzsARvGLPv1HpAKj0UiTVB55RKnCd86GHGyK9zi+ZnUQa2LLihzOCjqv
	/VF5QejHMVsbz6HGux6FT0TwMeBjK7dj3bxDuDbL95JFuDYhabANssUY1fv6v+YyqfB0CbpKVed
	ixJM9RLIeyi4ccBvbcG+s5DVcsiYALcVAXe5eiiqcMTlzhg30gSEPSM0G+1ZYq/V8MC/nAbskue
	7u3qUn5ZapJs+Tg==
X-Received: by 2002:a17:90a:ae94:b0:38e:7e9b:5fbc with SMTP id
 98e67ed59e1d1-38e7e9b610cmr5588949a91.7.1784617550616; Tue, 21 Jul 2026
 00:05:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260721063242.552774-1-arighi@nvidia.com> <20260721063242.552774-13-arighi@nvidia.com>
In-Reply-To: <20260721063242.552774-13-arighi@nvidia.com>
From: John Stultz <jstultz@google.com>
Date: Tue, 21 Jul 2026 00:05:38 -0700
X-Gm-Features: AUfX_mzCVsv5mO_nfkH4wgYd1Is51XZC_s9xLeJ72k68chQv1agtTANG4e2bmYM
Message-ID: <CANDhNCqBnmLfLb9cd47MnPiPUDFcGHoe6yN2Ti1zp5E3_a-Rng@mail.gmail.com>
Subject: Re: [PATCH 12/12] sched: Allow enabling proxy exec with sched_ext
To: Andrea Righi <arighi@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>, 
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Christian Loehle <christian.loehle@arm.com>, David Dai <david.dai@linux.dev>, 
	Koba Ko <kobak@nvidia.com>, Aiqun Yu <aiqun.yu@oss.qualcomm.com>, 
	Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 11:34=E2=80=AFPM Andrea Righi <arighi@nvidia.com> w=
rote:
>
> Now that sched_ext can handle proxy donors and BPF schedulers can opt in
> to blocked-donor enqueueing with SCX_OPS_ENQ_BLOCKED, remove the
> !SCHED_CLASS_EXT dependency from SCHED_PROXY_EXEC and allow both options
> to be enabled together.
>
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Acked-by: John Stultz <jstultz@google.com>

So far things have held up pretty well in my testing.
I've seen a few cases where the scx scheduler gets disabled due to
stalls under stress-ng pressure or locktorture+other workloads, but I
suspect that may be separate from proxy-exec (I'll continue to do some
testing both with and without to confirm).

Huge thanks for this effort!
-john
