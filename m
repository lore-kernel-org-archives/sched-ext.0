Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B152D94AB
	for <sched-ext@lists.linux.dev>; Wed, 17 Jun 2026 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695172; cv=none; b=SpbRt3djSGhv/nT+ZKaVMd7slaLwZvTcgXqJn5TwFd6Ef+pNaTDFsEouoPAN6WrSW6jPDlQMWlCFAoPcJzak688/ZxN5fJgglUaDzMNdmFRFZb+9ONpqERdCU6AqCfFH5697Nfkf+4u+YQQcLVUiL6PsSoDhOi6ISQN8EnPTVl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695172; c=relaxed/simple;
	bh=vq084jjvdIX0d2LSQEu7BuKRyVjwfnF+midvTV6TlVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lWsSVkFBZwHi2fI9tAv8oW/Yifx2zRedQMl61X0Tfsm/6cR9MQoRY1uY9vA52Z+kpRzL8kwV2MuiPel6cu8USDOVcTpgdwbeC2JdDsKSDBrYWGihH4Hw63X86BYKHg+DdlGaceA38bBZcGmPzWOcNcwyPPSML6OEyRsOkz40yws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ObaM/t+p; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ObaM/t+p"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6956a8abe7aso665132a12.2
        for <sched-ext@lists.linux.dev>; Wed, 17 Jun 2026 04:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1781695167; x=1782299967; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=66HDkq4Pe3xnmzINzY0aNppeB6sgahgOOsIpP9DjcT0=;
        b=ObaM/t+pIAjKSJuVjFNKQcheioxVRv4ZAbyPh5XRjFwBip1zIhnhK/4VPlYyhLTCES
         Bk2v76ARmaFGrQJl8lV2OfGiQqGwNBaJW40Iowrno2bp5HYShYJ8v7yot6+7LmZvJfIx
         ffwA9avYa03hQyMgXoO0RC45LDPou3q894L+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781695167; x=1782299967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66HDkq4Pe3xnmzINzY0aNppeB6sgahgOOsIpP9DjcT0=;
        b=MfpHF4y5FOPnY9J7CSVmOcHua1pc9rhxK8t5gNfCEU7WKi0n+qteRlUztrfty+QVFT
         cljgChBUyBZim7Xezma+57PIyQqWyWKcRmkVwOoQ6z++G/cg1YfQ0CxQlTlmueoYlbKl
         XA/GkuxXbqiQ14vCJekLfZ1lTt+qx0BCCyf3NMBNjxPe6pdzIGuSMdD5nfjH1DAF93Qh
         i1s/1MbSsVsu+/RufvAn8VMmWANSH40lnUFZg6GWIFQ9fPRU11NyjxPwTEH4jVozb08l
         kzEUMB47Yx3DiJ1s8PjrYZhW4zqvqwoo64DuH520H455ngbIyyrJgFJxuS2Xc1mHwTjG
         x2zA==
X-Gm-Message-State: AOJu0YzZJhAmfZZg4llmWuAyRWz6I3+bOXapuivU3KtOwGWoDLg++rab
	ttFE2du6e7TBqcZcPlhNRdWDKwKVeUxof2/6vhPgmSO0p2AVQLEyVQUFzUUdHI0awRiN+mjTf0U
	pjl/+1hWSTQ==
X-Gm-Gg: AfdE7ckamyZy4L9yCwPjIrwS+tMLbyz0vd1IqX+bKFBrj2doEoG5fBSRiuPjEn/GNXe
	6/VnkUr9xbeOWN2An1OnvufHts77KZ1IOdNQ9CwHNcPOlL/LBR3vsdmuxn2/RgwOoohHvlxMw+a
	4tJ5g3ThxGnrQfRS5+J+EmKWl9kjnEiMKiN6fBuy1x9qMIo0uYVqMDdfrnLjP5fES3zf+SaO4sN
	TZNrAGqpFamMGXnb0BzEWnt8Qewgr1EZ51dWeIvp/L4a36GEtFFXc48CQnnGPB4L4EBV2ujonrZ
	SOXIJQT6Z4Zo/i+d8aiHHoKVvXqAMxgvlLYErFhSf4qTsuoDkg27MIEg+FtRgxVAYJjxIKngOB4
	0J5vVB8CBH8s7GbKfprqStQz/+Fp92ELQyXCG68yS6gA5S5PRY4MMrA5EOk/L7eXba1s/oMysF5
	8clUkRJ5OozZGwcUPOtvjsrkW0FEKJisvjJyhcHmj+BQVLavARDz0Q0vThy1pxEg==
X-Received: by 2002:a05:6402:5191:b0:695:873:b215 with SMTP id 4fb4d7f45d1cf-695476c94bfmr1740484a12.20.1781695166703;
        Wed, 17 Jun 2026 04:19:26 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937919b4c4sm6077338a12.6.2026.06.17.04.19.25
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2026 04:19:25 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so6441145a12.3
        for <sched-ext@lists.linux.dev>; Wed, 17 Jun 2026 04:19:25 -0700 (PDT)
X-Received: by 2002:a17:906:208f:b0:c06:5ce4:7ca0 with SMTP id
 a640c23a62f3a-c065ce48674mr59987966b.53.1781695165656; Wed, 17 Jun 2026
 04:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <6a0da8f90fd3890f734555f1632a3a0f@kernel.org>
In-Reply-To: <6a0da8f90fd3890f734555f1632a3a0f@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 17 Jun 2026 12:19:09 +0100
X-Gmail-Original-Message-ID: <CAHk-=wghMm2c+AYEcwYY7drSVXB27DYqc-ZXpFiq=XFs-w59wA@mail.gmail.com>
X-Gm-Features: AVVi8CfKuKFUFLn76A2oOxLkwY8xCyWt2zr5HeS1Zb0zBwvY_AzFH_DBTJtnGWY
Message-ID: <CAHk-=wghMm2c+AYEcwYY7drSVXB27DYqc-ZXpFiq=XFs-w59wA@mail.gmail.com>
Subject: Re: [GIT PULL] sched_ext changes for v7.2
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jun 2026 at 23:56, Tejun Heo <tj@kernel.org> wrote:
>
>  create mode 100644 kernel/sched/ext_arena.c
>  create mode 100644 kernel/sched/ext_arena.h
>  create mode 100644 kernel/sched/ext_cid.c
>  create mode 100644 kernel/sched/ext_cid.h
>  create mode 100644 kernel/sched/ext_types.h

Please don't do this disgusting thing.

There's a reason we have subdirectories: it's to group files together
and separate them out

Using name prefixing instead of directories is disgusting and wrong.
If you have this many random sched-ext files, it damn well should be
cleaned up and not be this kind of mess.

I've pulled this, but under protest. Proper hierarchical filesystems
have been available since 1965.

              Linus
