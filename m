Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D14347FFE
	for <sched-ext@lists.linux.dev>; Mon, 16 Mar 2026 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773643004; cv=pass; b=Nw8zSwsuScNpObNGetzAB3N2H4LM1BeHHw2P8sWWR4diJRjyEI3EdscYJa0y2Rq3sj5cw05H/gKexQ9Q4SYC2V5ppazqWY/WiDfmicWBZ/49WWWV9LSJS8eHrSMnPv+vMWjh5rGjkEaeuavYOuma+mkpgsJusgQADGh+FyAlYgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773643004; c=relaxed/simple;
	bh=sNBDHdAidJ53F7Xud6CvN4WIcxzXRwDgKo+Y9mKX6/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U39xVUTAaBfrqB7Ag7/++CxjJAUMo8LnSsWqFhA5OQs5HiJW3Ahkq4C3U4j5mJ4irCYsgi1GDaMCTbJ50rO8o/zqM5Rgw/EwRRr13ifmxVcs8+eydyXlPyLB5b0NEnzC4A26LcoDa/LrW5vee0wgu8uhx/vThLLJZNQib5PVE2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrAtUbad; arc=pass smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrAtUbad"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-467161c4b7aso1946297b6e.1
        for <sched-ext@lists.linux.dev>; Sun, 15 Mar 2026 23:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773643002; cv=none;
        d=google.com; s=arc-20240605;
        b=gvuCakZgQGtQHFmZEmZQ5gtGpS0JUl9UdGQw6VJ2eOmTAZnBJHVF3FAsK2FcG9Jppq
         WC78AGorP7Qy2fafVd7C0XzHBhldBL37aS4ydF5+I76oPpBuYQmOvNuWhnwwZ/QBtW3/
         N0zFHAN8Whog92HvY5Fu8ZsrH+Mea0hY0N7SLsw/8WiPUs75SJiTMbbNGyycTWxj97mg
         7kAT1da6k9h4bQjop8oKk7AuFiKbRlc1OoIfHbch16nRpqYGUtTVYh/d18F2+6UDtS/E
         ElXLCtiPgtQUYPuP7oHYjRFRVrDvFcIINeb1F7rXr3en6yfTVUc6ZUmkcXngXZnXngi0
         emyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NPOuAo9YPIQaTwWEE2sWehbZ1H3AJjk4YUYUWxMKhEU=;
        fh=hFREBtbvlOoimP4Tr6sLPo2IFZaDnnVqya5pJo+mBqs=;
        b=PIH8MCWbxhBruPbgr2G86Zdt1hOsizfj1zWEAJIfXgg2R5KfdB5Aro9XGTa8fiGQLA
         SgVIQw47X4/RGln6BqH+Ifgo2oL1gCoNS+MIcZd+VQJ0Nu2qvDPVC26qoLTxFxCLKzAB
         bVPHvlCBsfpb8VXqlPbGMxeDjxEy822m9tK3g6NyzQzJWkmWbu3JoZfC74LsiOm2sTeI
         c4mCWktvQeZERIytlt2m6iDVolIYsZbfpxLQZdumpoB7IKIn6wDAv3KlZ1eJGwVCx+fe
         d8WWGjU/0RGIcN9VDJSL0NERVm2GmZ9qN/0MvFHUBq9p2PgeXb5I4mgbGn4XdqiGRabG
         fZiw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773643002; x=1774247802; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPOuAo9YPIQaTwWEE2sWehbZ1H3AJjk4YUYUWxMKhEU=;
        b=PrAtUbadaetkq1UbpN19y5DJYilx4luAGwG0D9no7FqX8a6KWjOx8OHe173nYs9HSU
         wAyTDzHoGrcBdb9SW5rDF1IFqo13sD20CRgy+Jc+AkND03I0eC8vLsxMMZVvWx2Eg/9S
         9RK0p2qePDl2OLmdK32/OnQFGATtSblEY3raiH6N89/PfLNqjgkMYsf6wEDuRfU+AD19
         RIDDwRj/stWT1kKJKzsKeLMDmZ5AKyob9h58cpODgCz74LN/D1HnFjpzArYhDLyGDZoF
         uu7JISTL61iMxQs/Iy6U/8DC3U8kWVP4JWWxgowbzfjWZu8+iQTVscRRuHsR7qRP4MPd
         8dOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773643002; x=1774247802;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPOuAo9YPIQaTwWEE2sWehbZ1H3AJjk4YUYUWxMKhEU=;
        b=SVKim4tc7YvXAVOSv1kQxtOqa8Z1EBsrpi0vLoe1NXT0ulv+nfosCxeMmGCI27nnjU
         XuqDhdSxIsjs7twMcoGiTc1w94UIsLx8pgyF9hQ+4WjHc0mOkiWgmZQ+FCehzIOssmWO
         E/J1mZFG8EhBc7pswimIvbXHvnnPiUBbzGV9H5/lVdWLxzzV9XHuEUGH0DuX67MCUIXr
         cR7MXOv92fBcjcVTYESkU5tTjhRVmm19PcNpwrleEZPbpu6b7TBo69u/SGMA8BY41U+a
         /FXcb1CKxIdoi7FJ8urZ1qePcaFc31RmsaM3X9tOKpLF7wXoiFEQqH5lYx3Yn0dGwbnF
         vbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvOmJs8Gf+cxRssqBnae4Lrs+2UaoHKv8Mc67XEyCk3Fbju5OtxS8o/EOW/V7yoWI0aa7h6ZPXIfM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxmuQEMaD7mAL07/Qh4fM032lH0FmXS+qxGiN4ZTSSOIdOw4g75
	2zjZcE8jaiaN9RNxcIxhX7FfH9rzWOvgyQi75banhSyT4iBHVZpvQWhbjxyJWShW1z7+5LULz8H
	kMo7rFNhC2gj8nTMiToSACTtP/m9zNcQvXg==
X-Gm-Gg: ATEYQzzp5Kj5K34tyyCM04i2Ree/9lddUgMTUUj1YhhfFWQqXAsLlZNt/kD+kapEDtr
	DDdiBuXbKMPqZy278ReCOhVQb7zvV/O4zpXeHGyPoZ9Ce1sthnDJ0AO7mE3JiclN+wngMNX7+NN
	QbhqRkUY6HpfCmKopZ+LMf4i1JLzuY8oaTBPTYVRuRnE+0L4W+EGdohkVl3QfyxV0FL6/tDQ7HL
	FFN+AFRTcMhSKvGGB+F3CrnS8WOTQJDV8Gycpb0iAsU2NlQT9BEpNZFnmb9bBiCcK1Xjtsw4rwk
	Ov3woRmh5YRqWOKtWSGztLWDsmp/8NfQjawcwg==
X-Received: by 2002:a05:6808:f10:b0:467:3f4:9074 with SMTP id
 5614622812f47-467575d1a68mr6074075b6e.53.1773643002491; Sun, 15 Mar 2026
 23:36:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260314134457.46216-1-devnexen@gmail.com> <fd14e347a72d374cb02bebc9c505a891@kernel.org>
In-Reply-To: <fd14e347a72d374cb02bebc9c505a891@kernel.org>
From: David CARLIER <devnexen@gmail.com>
Date: Mon, 16 Mar 2026 06:36:31 +0000
X-Gm-Features: AaiRm52iv04y9S122yyvRRMuOBwpln4YLHojygYRB8M8ANRbwjgzP7O_bD7bNHk
Message-ID: <CA+XhMqzkY5cq6HSkvd=tvezoAydDfn3YPwx+T3opYhWNcwz=tA@mail.gmail.com>
Subject: Re: [PATCH] sched_ext: Use kobject_put() for kobject_init_and_add()
 failure in scx_alloc_and_add_sched()
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"

ah yes I ve seen your patchset, it is better indeed.

Cheers.

On Mon, 16 Mar 2026 at 05:43, Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> Thanks for pointing this out. Using kobject_put() is the right approach but
> the release callback (scx_sched_free_rcu_work) also calls cgroup_put() on
> sch->cgrp, which was already set at that point, leading to a double-put with
> the caller.
>
> I posted a patchset fixing this along with a pre-existing cgroup double-put
> on the abort path:
>
>   https://lore.kernel.org/r/20260316054328.838304-1-tj@kernel.org
>
> Thanks.
> --
> tejun
