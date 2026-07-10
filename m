Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96D43254A2
	for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 20:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714638; cv=pass; b=jyuNER8ATzdRsxZ4EjJgteE5rcE3GSj3wY9lObZRutkg9x+XsqYDCktRije37CA8epct9us+kwWBu89H+iIn14KWElODV+vm8KMjkKHVIgTNeXFZyKhDcROVQ0vTSmiRCB9veac9na4nOFY+H7ZoJMOSwOOsjuAF2Y6G3SPJkN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714638; c=relaxed/simple;
	bh=Y4PxDIWZ8cuCtlKygAvLCUl9kmb0W8gzO10lBIXLIFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oterEVvJXNsebSJ3m4If5SI3lnZ0+dMqhmWhPq+CjSPjBw0SiO/BV4TgfI/MI60xgEe0VsIPPOPSdnnFW3yPdf2SM/dXnbV2fHwkGF8c+gjWowApzE4KbnxOp/90Ii4GURf2YIpEu+iSvdi7B8BF3JRqKV+egR/iEBI/dvPcYdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci34p0Ly; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci34p0Ly"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so136139966b.0
        for <sched-ext@lists.linux.dev>; Fri, 10 Jul 2026 13:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783714635; cv=none;
        d=google.com; s=arc-20260327;
        b=VaKTd0OTesvMeUXwKzIAyMVGLcqjHuSca9o2Mtymi6Agt2q+X0hGhTqYON+HNs836g
         lMk6lN5m7EqmoZugtSsPXYQop39Qxw/HUYgutXtJyO9rTnm/9iauDBcKOKRMS0UXMI/7
         d4AXOuQR9i99THXsyhaSABkcv3raQH/GtAGab+bMq/guWgB3AO9E0zDsFJMLR6GuKNbg
         IIFEXygm+bU67OfRym0B/9+4teZo/a3s5YhLtiYVupWIIQT+hs4OatvdAERibxI2OSsS
         eK716g+7IE8HR8vpOl3UDejQ3N7RQ3Ps6H+e0QCtbFhH5vBy+LBTKuT6CAGA5xYV81Dp
         S5KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4PxDIWZ8cuCtlKygAvLCUl9kmb0W8gzO10lBIXLIFk=;
        fh=aNmBkdO9K8OQu8ZZqjfJy8wYAwrcV+KQTaIRkjvQeZU=;
        b=ngS2WCrS0HrEysiG2Wwcr5PO056Ov9qYwaBlsKhCRqIz6RpDvZSs9jgTu+NaMQKlPm
         Qpf7nFPwXbxX0l5N3s2g+xnsnyHZ1V1ZwghK9kbLA6X+ilTdKaKru854cg2kqjN56i4m
         0XduQAbTwLiWEV+10EOcEPSKAcYSuEW4MvJK+PZTislgK9FIg0O6bpDjtsyRzcPScHkk
         K3doQON5TpmuQNJQR7qasl+vTRVlIWxN34Zg/RemFxEo2dkTtYV+HQvY+BTl7XHSaRDE
         ClpqHmmJr+8bb3wASYpntkQlXI8y2CXd5LFesYA/hbS4CfW1mXBOGWV06QFVZ+w6JBC3
         xYHg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783714635; x=1784319435; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y4PxDIWZ8cuCtlKygAvLCUl9kmb0W8gzO10lBIXLIFk=;
        b=ci34p0LyjfQRCtSMMEahKFURHvhkgityWJzCTrugl0ld2N0R3vP8ufS/foaBt9yd54
         VhpML8qXYkSV6vpTsf9MhB+u7mxwEyf566oNeyvCk+1BAygmpyXDZPqupmXLcHoFbpp9
         EabmGkWAt0lX+7fBgwcU2VD554o3W+ls780d+jePDm70Q6TJKDxA/Dj7I0LB3beKTpHe
         7SXuaz5/eOetg4UaAsep369ZsMJBJx6HU1rh85vQcEyjv5Fuj3OAtnN5XVeY3C3wJiZn
         OBM9snqPbVpktUq3LsE5pHZ3L3ggYv8xv1mvrfet3Ds5upHDxyi7OrHzSyG9sL/bT1sh
         5s0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783714635; x=1784319435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4PxDIWZ8cuCtlKygAvLCUl9kmb0W8gzO10lBIXLIFk=;
        b=hpMUpfrzYAdaGQUCeD7NWGu+b+Fv03OxBOeQXE/sNdmPAY3vVoX/787wEaLhbMo4nz
         AiP+tuAaeDZqXkPfHzluJ8tkcy03qiVkAppKdV6SwLp7s4r/cUgM5bhm70mXZbNCzpff
         d6ilJjoEYhGnHIG50XRMY69lama/w0myVTwf86Cu3QqzNsteQbdlPQziSmZ16s989L90
         O0VSzeHgPoZdgWqYoxBGoH5pfA4h6sVueZgMZ+/xaVhblJegxb8mEmTq60DNXCz7rwH7
         V+6+euhwYof/+BNyrN6ZaACXbxPxq0VZqchiNyuha1Lr2v4/mOOs82yLUSmHw8H4UsFc
         P3JA==
X-Forwarded-Encrypted: i=1; AHgh+RpPQsmfUOuotUFrLSSN8y6k6RaQPOY0quJEDSCBbrSL8fTwkc/I9CxjEwsCdYMnkSxFDdMetZte8jk=@lists.linux.dev
X-Gm-Message-State: AOJu0YzA2b+2Rsc/sokInzy/flEuION61MsqZ04YKYoC3T/0JU53XTXd
	Gg/rRNJ4EdzH5QHHG9PRdsB3Wy8d/OO78+j2+XdhytciyOMU4WEQpe1bDHRQhp2WnOtCbfUXiGE
	+66q8AUmU7q9DPLTu9NKmT4yw9RdacX4=
X-Gm-Gg: AfdE7ckshRuuoKNmd5azYLwdSYCOCRIOlPes9fGisPesLLl6eUtzbB82NvLy7/wXhjK
	W0PxmLe1ItS7nKQyYjBS8Kr8Fkwu5DoGpd8fxuVZ0nfVWCAs9XC2dFT7NwDecVq4UagTMO/WXXB
	Kyn2vgKwENuICSN5qvZk4pBQXBpKlF+FaJHlXgmuaaa2I7TVRTM8mOEIZzY07Bn2yLZFBAngXLV
	NF3brtHZp19T6vEJvzJtDCTjW2LjaVzWtjNjvE8i7LFhT88zvk3LsvzhXEymOQo+5wW46gQhFI=
X-Received: by 2002:a17:907:3e1f:b0:c11:efec:6ca9 with SMTP id
 a640c23a62f3a-c161e957178mr13260166b.8.1783714635022; Fri, 10 Jul 2026
 13:17:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260709182800.2037938-1-main.kalliope@gmail.com>
 <20260709182800.2037938-2-main.kalliope@gmail.com> <20260709183918.E42371F000E9@smtp.kernel.org>
 <DJV4TO9OH6AN.58C10SBPE8FF@gmail.com>
In-Reply-To: <DJV4TO9OH6AN.58C10SBPE8FF@gmail.com>
From: Admin <main.kalliope@gmail.com>
Date: Fri, 10 Jul 2026 16:17:03 -0400
X-Gm-Features: AVVi8Ce7nxoaP15UgvOn9HuvcMHcwPU6nRe8Rrrfu2vJWWJjWqqoYYbC7UgQaF8
Message-ID: <CAJZwKki8MwOmij3JZK=KnnO0hEUuxWA-iY=GK-TtvtVRvOkjOA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Require a BPF cpumask for bpf_cpumask_populate()
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 3:18=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> Once this lands, please send a follow up to address this.

Thanks. Patch 2/2 covers this, which updates the cpumask_common.h
declaration to take struct bpf_cpumask *, drops
the struct cpumask * casts from the existing populate tests, and adds
the borrowed-destination rejection test.
