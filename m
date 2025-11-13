Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD579280CFC
	for <sched-ext@lists.linux.dev>; Thu, 13 Nov 2025 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763073209; cv=none; b=eQkiw+N8h5NksOSnn5HW1KARRJaHdshbZoWpysaQYihS7qsRTGDeNbYBLKJfeAF5kwG0Mcjv7LnKQGeDYEu6ZHx2hgfJW6xoKnyLWOJ0S54THmLo3bdq6GdrUBCUFdc0ZDjciBrpampCYR8TRpLvXaBQE4k7TYwSl7hPQJtcMNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763073209; c=relaxed/simple;
	bh=PDIzX9lP5XQZs62gIl6uP+qrLOHr2yXDIMLJLRKcSnU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MD0tWH0bl2646of2fBJZ//x48zOOIWAsyd1UgsIvV2i9CxACS4FGEejOvP5qeA0dtgflCJWSr7q8UW0hYcG5cFn0pEL9NAOei5MQESY7haAd6ow1ZBmsD4YaIr8SItDPb2yMYNfmJ2CwlZVrRelpbDEupRQ4IefT31pyEkd+klk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GYnmBUJA; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GYnmBUJA"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso2493512a12.2
        for <sched-ext@lists.linux.dev>; Thu, 13 Nov 2025 14:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763073203; x=1763678003; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVCEm3ESLcwEgVE95mHJVsu9HGvMxSNrykQKspNXJ3M=;
        b=GYnmBUJAcTux9g0bfbS3B8Lc/cGQkC0wAeSA2c/8qrUf9D1xwGeaEbexZx78BpPKlh
         6B/Y1AQ9uoXjg0vivWwRvfXZiq8RgpwiIjxEwzPB37py0GEmMMm014tgjMw9V6wdV4/O
         +b9rYRB8vo9kDq+NnsxHv6k2NR/qRcfaozTcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763073203; x=1763678003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oVCEm3ESLcwEgVE95mHJVsu9HGvMxSNrykQKspNXJ3M=;
        b=AheQZEPC8zQIdbKNo5DoxatnTHQuri1frr4uaGYwM0TFisOzD2Toeu1bV9ePsHzt9L
         ANDS7KP8VKBNk25myQrRTybJaSNW3vyy6Aa4xZYZQub6yf3DwQRdn1APVav7WIoXj+aF
         cj5kq32s3jv0DA/YGFXMDbD+DLimN0VYve2anhDBzm904KVK2Lnf0bUylNR5qVNIVPb1
         pESQQ9wFK27EXoT8L9OW5jH55/41OCf7itjT8DDw8AxftE5xFyKDDv4RpipCTRjFH7YZ
         vmWbgxisvX0a3pHhbax6fHTa9d7EbE0F/mdpsoIi/i7YCIlK58xDp8mPMJXxRFzvasOh
         S18g==
X-Forwarded-Encrypted: i=1; AJvYcCWYuoKRalJMXkAnVzlNNcQJ/kv7AO9epUlq6x1Jd9hDk0GM2XBR50lOuxYkfEdl1fjNf2m8lC9a/aU=@lists.linux.dev
X-Gm-Message-State: AOJu0Ywf14dLTEaEr5HqKsazum9pn4G79uoPzkb0SptEuwV4SIDkiT1N
	Qm2tnZI9I4S0im3BSLwzNM18C9Aa5nryf70HzlWI5pTF0JLCzeSURdFyNCBL+eveL1WIgfgG2YN
	K8/yftHaL
X-Gm-Gg: ASbGncvCuJoNvfAGaR+WO6ewXw7XpOsN+uaPmuu2GVzeqbuH+8GqU7sRvkFhh9SRyF2
	89B2qso59639yvawpfxmOKSVtsFfiNpr/yTb1HH2qOs86IxgerYbvh4/6Pb9QACyTRglAPt1SE2
	gKtQyCMOjsT0SRervxqppYGf2iEGvHfhowT4gIF/LPIe6ftuCbE1Qh9yQqrFArrQTQ6sjQCHNBA
	4grKbYMypuQtoEDGZJY/DOGoVvOGt1H5yTuJx3Zkbl7dq+nPTWk0lxJG5GFK4N3pwZjdvnd2RRY
	CGBb59/LkRwKPuN0HnHGcIKxlIaV817PdYkDxULUSG+2lZq6ewowre34jwv8PZdclqFzow46mtl
	ZTFF1BpD1wvBjyaq64OZB0tWRDvLq3M6O4R4C292uzN9AFKh6vx3Jae17ap/6yL2OUA+2zKWglD
	L8ZC0+hjrabBkOB1YcAcVE1Y9dycON+mVoNxIsH5oqXlOUfrxaZ1N9U1BtUdq3
X-Google-Smtp-Source: AGHT+IGRSZnHs5sHBmd899NS5Q45YFfBTD1Dz7rW/dQcOvGmYNkAYVSyO7dzQ2fcEQkuPAnPnR5S+g==
X-Received: by 2002:a05:6402:42c8:b0:63b:ee26:546d with SMTP id 4fb4d7f45d1cf-64350e20abamr781358a12.12.1763073203178;
        Thu, 13 Nov 2025 14:33:23 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a497080sm2436996a12.19.2025.11.13.14.33.19
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 14:33:21 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429c8632fcbso972797f8f.1
        for <sched-ext@lists.linux.dev>; Thu, 13 Nov 2025 14:33:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWIxa5xWNfU+j8sMLwbUm3Fx0Mef8/81a+J6HwfsOUGC9s0o3Uag4HQMnDA9TFKqfjYMqssxV2kWdw=@lists.linux.dev
X-Received: by 2002:a05:6000:240d:b0:3ea:80ec:8552 with SMTP id
 ffacd0b85a97d-42b59387fbfmr895739f8f.57.1763073199362; Thu, 13 Nov 2025
 14:33:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251111191816.862797-1-tj@kernel.org> <20251111191816.862797-10-tj@kernel.org>
In-Reply-To: <20251111191816.862797-10-tj@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 13 Nov 2025 14:33:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Ujf7PJxBANGv4e6oVa9YMS4sNLvxp=u+=5n5aaAAn9Cw@mail.gmail.com>
X-Gm-Features: AWmQ_bmwsNA5UUBf3Oj0I62MqxI3MMj3dL0y5Ob5-d1-PwxKoO8eKORSRZ3aghs
Message-ID: <CAD=FV=Ujf7PJxBANGv4e6oVa9YMS4sNLvxp=u+=5n5aaAAn9Cw@mail.gmail.com>
Subject: Re: [PATCH 09/13] sched_ext: Hook up hardlockup detector
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, 
	Changwoo Min <changwoo@igalia.com>, Dan Schatzberg <schatzberg.dan@gmail.com>, 
	Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <arighi@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 11, 2025 at 11:18=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> @@ -3711,6 +3711,24 @@ void scx_softlockup(u32 dur_s)
>                         smp_processor_id(), dur_s);
>  }
>
> +/**
> + * scx_hardlockup - sched_ext hardlockup handler
> + *
> + * A poorly behaving BPF scheduler can trigger hard lockup by e.g. putti=
ng
> + * numerous affinitized tasks in a single queue and directing all CPUs a=
t it.
> + * Try kicking out the current scheduler in an attempt to recover the sy=
stem to
> + * a good state before taking more drastic actions.
> + */
> +bool scx_hardlockup(void)

It's really not obvious what the return value for this function means
and it's not documented in the kernel doc. Could you put it there?


> +{
> +       if (!handle_lockup("hard lockup - CPU %d", smp_processor_id()))
> +               return false;

handle_lockup() and its return values also don't appear to be
documented and it's not super obvious (since it goes on to propogate
to scx_verror()).

I spent 5 minutes looking, and my best guess for handle_lockup() behavior:

If it does nothing, it doesn't print anything and returns false. Then
we'll continue to do a hard lockup.

If it has previously kicked scx, it prints the passed message and
returns false. Then we'll continue to do a hard lockup. Why does it
need to print a message in this case, though, since we'll print the
message once we return "false"?

If it disables scx it doesn't print anything and returns true. Then
we'll print a message about scx getting disabled and skip the hard
lockup actions.


Did I get that right? I didn't dig too deeply. I figured if it took me
more than 5 minutes to figure out it needs some documentation...


Also note that the CPU number you print here is a bit confusing. With
the buddy lockup detector the CPU that's locked and the CPU that's
running are different. Shouldn't you pass the locked CPU into this
function if you need to include it in your printouts?


> +       printk_deferred(KERN_ERR "sched_ext: Hard lockup - CPU %d, disabl=
ing BPF scheduler\n",
> +                       smp_processor_id());

Should the above be "disabled" instead of "disabling"? Mostly because
(I think) it already happened. Otherwise as a reader of the code I'm
looking to see where the disable happens in the future and I don't see
it.


> @@ -196,6 +196,15 @@ void watchdog_hardlockup_check(unsigned int cpu, str=
uct pt_regs *regs)
>  #ifdef CONFIG_SYSFS
>                 ++hardlockup_count;
>  #endif
> +               /*
> +                * A poorly behaving BPF scheduler can trigger hard locku=
p by
> +                * e.g. putting numerous affinitized tasks in a single qu=
eue and
> +                * directing all CPUs at it. The following call can retur=
n true
> +                * only once when sched_ext is enabled and will immediate=
ly
> +                * abort the BPF scheduler and print out a warning messag=
e.
> +                */
> +               if (scx_hardlockup())
> +                       return;

Should your test be before the "++hardlockup_count". If you return
early it doesn't seem like you should increment the count?

-Doug
