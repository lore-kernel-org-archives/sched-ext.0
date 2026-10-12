Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751D3803E9
	for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 13:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811064; cv=none; b=Rl6aZ/jhHYGoOgLQ4DkiJdp4YWos2lPZJeiY/KuuGYzMNi1sM/HUlwPTMoARySIDPumrZQ5ztzfsbEChl2mJGhc8YgsF2ncoBAE7DqM6WhPb43i9ZTF/lnA+fHYdvk7rWk7Rb1l8/lm2na0ffmLScUWIgewShSq2Mb+Bpt/lz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811064; c=relaxed/simple;
	bh=sWZj4fi9PchIWq6iTv6FoJJcUWY4ROJjikopBkr9icg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jr6xbIxg4dRpqiTVN6WJquVZNB1XVJZrkTbu+sYT2svn5SWWne68kTIj8Y6uKFNo0HP6iBgsOlNf3ngFkvuOz82vXImVozsUDmXATMXFnR9UUU1wFGS2r43ZOSsjWrGLeXOjDf16MqW4JpqWr6AU+PvQLoDkmWVTWXnxr7mbLZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oYAgiRsj; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oYAgiRsj"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a013ea30c0so12960565e9.0
        for <sched-ext@lists.linux.dev>; Mon, 12 Oct 2026 06:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791811060; x=1792415860; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+fEAaRgfVTrd4ivzqjJHoxub+cLoCC1NeXyWvtmvqHk=;
        b=oYAgiRsj1T8aJcEKYvtF4+Z/JxL9qfeegzDL1TfiX88v+LABc1V1K+C1tAmD9oCk6U
         KUudsRZ5823zn9ZusWb0XH9pBwHspTd+m9Pu0ITFHdivfo66n5lrxzLcXLxvX2Hu3IZb
         RvW8fl2FZvYMT0Wx/m63j/SmC9PlyQ0KFvvUGyUONXulLAnxsnINA488enKSVKXmjy8D
         5L1gZTuBtAyt70oTjFCbsBbrnjxAIoCTcrAYnBvry0dNbMNxhvhCquoQcCLcp7WHIhvB
         XGvUXFIERgr1otdawCxiIrqmTHul9czyJhqw65uumgJeKCSIzZ1I/LGf5AiwYAC9qwSn
         TxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811060; x=1792415860;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+fEAaRgfVTrd4ivzqjJHoxub+cLoCC1NeXyWvtmvqHk=;
        b=DEeum9R045NaIdVbgNt34CxbX2payDrADWM7QHL58dR/6vP4zq3UOsdUXEv4bk5NWd
         NKxl7t/e9tJwvohQLz0XJXjRrD09lt2w4qIBN3t2lex3CpQ4QqxFyVtGOR9HVizdp/O9
         79Q4VymTOIQB7Txv+ZxauEdTavRsT5TziSN4np3P/wLIbRoLA/bt9D5uw9aUC/ndwqn8
         RcZpdS1wi80lpdnT2rjlVAwfziYbZQJ5fBNvSK9oHXtcRfc8Di4tm1ATVXGe7D7ChGyN
         wGmv5MeSDxUgrZGOxm0fJt+aw5iJoRFZt1XtcOqb3wl3dqeGhJhCyvHU3Bzfu9a179CT
         Z1fg==
X-Forwarded-Encrypted: i=1; AKwUvBz3E8LQeoMmozZdEgYgYdFveA5BOb9cvAWHP4cpGTePWdQB4qqpM/3efToS1E7gpTIq3T2DNEQsbDY=@lists.linux.dev
X-Gm-Message-State: AFq9FYKxV8zMBETbnIhOsuEPkk1n4hzNeYu7U+g3N01i84rSF9QPlxHv
	biWZ5DHeVZaiTRAMJL3f+Nw3o2aUc5JWZDoR7Si4iIUZmmMZZ8EMF9XbE64+eturxTEaq1NpHwJ
	MXOKiIBNgurN7wQ==
X-Received: from wmoo9.prod.google.com ([2002:a05:600d:109:b0:4a1:8741:47d4])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b28:b0:49f:ff7b:f056 with SMTP id 5b1f17b1804b1-4a18e4a3c24mr156632435e9.9.1791811060039;
 Mon, 12 Oct 2026 06:17:40 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:17:39 +0000
In-Reply-To: <20261012115928.1372317-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20261012115928.1372317-1-smariotti@disroot.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
Message-ID: <DM2W05XKJT97.2ATHPA28J84ZH@google.com>
Subject: Re: [PATCH] selftests/sched_ext: Fix build error in dequeue_remote selftest
From: Kuba Piecuch <jpiecuch@google.com>
To: Samuele Mariotti <smariotti@disroot.org>, <tj@kernel.org>
Cc: <void@manifault.com>, <arighi@nvidia.com>, <changwoo@igalia.com>, 
	<jpiecuch@google.com>, <shuah@kernel.org>, <sched-ext@lists.linux.dev>, 
	<linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon Oct 12, 2026 at 11:59 AM UTC, Samuele Mariotti wrote:
> Building the dequeue_remote selftest with newer compilers (e.g., gcc 16)
> triggers the following error:
>
> dequeue_remote.c:39:32: error: variable =E2=80=98sum=E2=80=99 set but not=
 used
>
> The 'volatile' qualifier prevents the writes from being optimized away,
> but does not silence the warning, since 'sum' is indeed only written and
> never read.
>
> Consume 'sum' via an empty asm() with a register input constraint, as
> already done for the dequeue selftest in commit 3788e3251653
> ("selftests/sched_ext: Fix build error in dequeue selftest"). This forces
> the compiler to keep the accumulated value (preserving the CPU stress loo=
p)
> and avoids the build error.
>
> Fixes: cc07fae1de5d ("selftests/sched_ext: Add a test for ops.dequeue() o=
n remote local DSQ moves")
>
> Signed-off-by: Samuele Mariotti <smariotti@disroot.org>
> ---
>  tools/testing/selftests/sched_ext/dequeue_remote.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/sched_ext/dequeue_remote.c b/tools/t=
esting/selftests/sched_ext/dequeue_remote.c
> index f2c1901030de..af344581d5f1 100644
> --- a/tools/testing/selftests/sched_ext/dequeue_remote.c
> +++ b/tools/testing/selftests/sched_ext/dequeue_remote.c
> @@ -43,6 +43,7 @@ static void worker_fn(int id)
> =20
>  		for (j =3D 0; j < 20000 + id * 1000; j++)
>  			sum +=3D j;
> +		asm volatile("" : : "r"(sum));
>  		if (id & 1)
>  			usleep(100);
>  		else

LGTM, thank you Samuele!

Reviewed-by: Kuba Piecuch <jpiecuch@google.com>

