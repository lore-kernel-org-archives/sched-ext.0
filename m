Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6245433E68
	for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 13:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950601; cv=none; b=H9KHTAf6zgWC1KXcjP0auKAmyrLDCr6KurXJQgziTvgBtmC0c8XoBVj88pN+vrINTrmje2rvKe5oIKcvLFqv3mT4U4/bPAMdfTHbMLpHJZlnVptE6lVvU199c4eRME/dutjLAVgQooa7s46ZdaIODYM839pn3Jy+ekhNEXad0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950601; c=relaxed/simple;
	bh=+lMCCcsL9KhGqzAnvde2v5Etjt6yi8xbmgjj8iFutzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjy34xcOTpWR7rJa8BqIwoh/SjwC2veKm0vJVJeuH7mVYb83+ePSOA0+7DHxAvezi++tuS24MYwzhBKwS6as6nlpvrfqKMoQ6w6+DwUfsENr4ZDBOzI9z8VqvdS/yFAzcpMoolRFyChWMyInZR6+Wzq7k+0idqf69mjLde2P+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=ASlvNnmr; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="ASlvNnmr"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c1630cc8d43so160625366b.1
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 06:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1783950597; x=1784555397; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gHaZPwi3IrnhWNTxPLfcIu6e1zyZHnrUTB5eDWHk9VE=;
        b=ASlvNnmrOP6i1GfnnGN6+OaU6uhy72+Z19dFnu4vdZ6AszBwN3/OsQ6j+xWLnvx9v6
         yAtlYqjtm8M+zDtVyC+33WSdXBwNzGhdcVvXD8eOVzgbDKJVdhk/8In70xEPJB8urvd9
         bnawS0QUtUOxf5ubF2wiumHN/aN5/LOqTsWAY+aN22cuJRs7GsWXfY1QAFHU6fEfm+0m
         VxZYBRODTOHJbt0ZRt8ijYnQdH4ay2oUrdsy4lGKZm9an/BPQaxc/VY3bhCAygEVNA0q
         EPJ5VrZTrDOdoxT1uXhjO3IKbqbOPj+vOXYAzQq0s+MelTJMACYARqmas3eMv2E0NReM
         TqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783950597; x=1784555397;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gHaZPwi3IrnhWNTxPLfcIu6e1zyZHnrUTB5eDWHk9VE=;
        b=KJITZvSHj2HxwvhAIK1vv02RnjGGFXHauO6dlNEYhmYvYb7fTs1RU0HE1r+qGFyszQ
         4gBYnFR6mK1ku6V4T1bssJsjdW5eKVsszic8cC2D1/8K2JGU+0yxoC5opKSOOPi7hAsC
         atzoMr/5BrUguWASGUHIyVXTGYydrXMHIhnjfnJTDmrne2ny3yUKYuqg+MUMybE7Qxxl
         E58d3MKWDWs2blWEhcY8gvAIia17Qac4Q/QupfwEEHDacdWZo7uMkKltMNKv2HSIL81j
         3RLe2BY7z1MjGsIgjeIJHkLrURhXE9ach9NQV7hgrmOCFqgLU4rIc8wVXjTOhTU0QCrN
         thHg==
X-Forwarded-Encrypted: i=1; AHgh+RregJ3xN31y+amTn0vKQ3Cei1as6nvkvb5pFRIAyxglGqJZQCr4mh0gHVJ2/AOVNE3uktYSG7dkJjk=@lists.linux.dev
X-Gm-Message-State: AOJu0YxjhYuV3S7YgU2ef/ozhvFpT7xv2tGyaPYjycgQ7Y4KZEDd4TaN
	hpqV19kuNw71/TikW2lHSoSlg6R2NVFTpZSl6BHYTT8OIYZ/cDqPu8OXncUmstzEADo=
X-Gm-Gg: AfdE7cnFt5sXJd6X7egiFlldWYbtD60uBNwBWgrH3EkhsWMOQnMrpZWoWQ41sdI3HW4
	d3w8kO+G/znQohaar95VKNPzJPK/W1qFK53jCpAyrsbioLmz6dhWQgvqZk7h9PdocQPWVmpTTKt
	UnQ9jMiu2uYFIbgfSUbDdUAvmhSi2J9AyYnaCppjfWc/DJ2al7BEQECeKO9C8GU7ISINNOjg+S3
	l+aoHZz7IdtcHV7Z04rMRzVoDMj/Ga6RSuKzV9NASkcQ/+x4z01C0RULfv3RGBYWqPArUo2DO3+
	JW15Lecu33r4A4PBK6AZoEKa39ok0LoUlHkwppFuI9zSF5sGmRPdBNbzGZK5xuMukSYWVEHoE9T
	LQO0UaNxQSya3+BfOrHieB+mhYcJgF8K5j8r+OjwsOOMZQugqp3i26xB4dlfNMyMSIw7e5Af3fM
	cC
X-Received: by 2002:a17:907:95a8:b0:c16:581a:2a51 with SMTP id a640c23a62f3a-c16581a50bemr62872666b.12.1783950597109;
        Mon, 13 Jul 2026 06:49:57 -0700 (PDT)
Received: from localhost ([2a09:bac6:37a8:1f19::319:116])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ca1bd81asm819021466b.30.2026.07.13.06.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 06:49:56 -0700 (PDT)
Date: Mon, 13 Jul 2026 14:49:55 +0100
From: Matt Fleming <matt@readmodwrite.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Edward Adam Davis <eadavis@qq.com>, Chen Ridong <chenridong@huaweicloud.com>, 
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>, "ziwei . dai" <ziwei.dai@unisoc.com>, 
	"ke . wang" <ke.wang@unisoc.com>, Matt Fleming <mfleming@cloudflare.com>, 
	sched-ext@lists.linux.dev, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, kernel-team@cloudflare.com
Subject: Re: [PATCHSET v2] sched/psi: Fix psimon fork deadlock and
 rtpoll_timer UAF
Message-ID: <alTs1drVX4kb124h@matt-Precision-5490>
References: <20260712174619.3553231-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712174619.3553231-1-tj@kernel.org>

On Sun, Jul 12, 2026 at 07:46:17AM -1000, Tejun Heo wrote:
> Hello,
> 
> v2: - Retagged sched/psi (was cgroup) (patch 1).
>     - Added a fix for a pre-existing rtpoll_timer use-after-free that the
>       Sashiko AI review flagged on the previous posting (patch 2).
> 
> v1: https://lore.kernel.org/r/20260710134945-psimon-fix-tj@kernel.org
> 
> a5b98009f16d ("sched/psi: fix race between file release and pressure
> write") made pressure_write() fork the psimon kthread while holding
> cgroup_mutex, which deadlocks against the sched_ext enable path blocking
> forks before grabbing cgroup_mutex. Patch 1 moves the fork outside
> cgroup_mutex. Patch 2 fixes the use-after-free from a schedule attempt
> re-arming group->rtpoll_timer behind psi_trigger_destroy() by shutting
> down the timer when the group is freed.
> 
> Matt, patch 1 is unchanged from the previous posting except for the
> subject prefix, so test results against that posting still apply.

I ended up testing both patches. This resolves the issue for me!

Thanks,
Matt
