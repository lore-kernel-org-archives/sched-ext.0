Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52189246764
	for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641129; cv=none; b=F7bcw5vxS7XtlaGr2DrnauPye4EHTOkQzmKfDMkEwpkh9EugolL0e/Cn7Gvw2yB+btT27eU0C7FA2c+MxX327hOio42WTZzrltFr7n/WKloa7ASfvR4QC72lp418+yGGxMlSTotMAioPrIPBOBiQaMkz5WZqv3xXf+gZ2tG6sP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641129; c=relaxed/simple;
	bh=JAs8cmBMqm3kFdExAU2wLuKhp0hhzgMnaX1Q1vHYD2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUpqxg4RbOnVtPglQocvu/ErN/SMbncw5Gk2WMfBkzvaYvYUfj674j32nZ+1edQ0h+PXy0l4OeGV0N8sI0FltUdF1S2ySI0kDzoz1v8lfy6z4g38em8oO1TvETA/S+JXPhDGCoBmBwuRxvHpi0cCSAKRCWQEljPf8FYQvNFq10o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AwflOwBa; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AwflOwBa"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2e0513433bso304698566b.1
        for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758641125; x=1759245925; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NHqkMf0CIdPVb3vixYXIX4KbVCIYAv5dXkbwV5m89bY=;
        b=AwflOwBaEPMEGsCi9SRnvnMmmPQ4a29f2zpW4zV3pHbr/gts1BWOvRdWEuqfjWOp5m
         mT/WnLqQqBNNdMRpFpZIzyjT6EzpUhLDNGIefFFJN9JQG3Gec3n3cq25H9ttdPunhLUt
         LfwUzlBcNqWkaxauRWCXE+HR3hedyPeGn6m+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641125; x=1759245925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHqkMf0CIdPVb3vixYXIX4KbVCIYAv5dXkbwV5m89bY=;
        b=LIgxhxrx76EasSp+jHumW6JVP7lhtGVQm7P0AOssiRrEVHZq+hr84JFg5pfI3auad6
         HGkhQ3Ex1wLfLtM3SziFprL7LBlIXuIsQawP61tQdGoOHhuYEnoATfLWTETwy1oC534D
         8G2wnFFj9Pi8Bvn+iMmPfWnMDQF76Y7eiYRCoGz0q6RegvzktkrsWYj9xm51FxlMPqug
         E/GQ5s9xu03CMso9Y07QFAkWoEVTOkgcfGesML4wbY6TBkeeKhMwKQfwu43gw56+Mwq3
         S3o8+1VS4uH+VZh6yw3GtY1K2ejf08GO8Pteobwedy/UJ9VsVFOcS1JFolfmbMhlBxw9
         hZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8mZ1vV6V7WhkpLoN3e4gKUcGoCIM3WXEqxZDC1FxHP+xMVG3GBBXFZCH+Dkap6CODfw1CCq4iay8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzJ/9jAZVpwhfiNSnyYcEizRBY6T/aZnpan0hCqkKK/LgGPKxqg
	hVLp4EAw4KqICMWb1hKNNzdZ8WPbxkcBxmk7fBVH/0zb8GPeSp2xFQxnlABpfZP1UqhVGTN7g0I
	WAHWC2HU=
X-Gm-Gg: ASbGncuKp8oo5GsmHlt1v2hQlIuUL63gtSmORgPlqiVvFT0Atgu+OIMGudd7HP4zlGN
	RsKocHcTXKR5PwSnM1Q08fXlm5N0iPMVKL3FS8fM+tXy2O2Qcww2I/U0sl3uJUUcZ4+CuGg1v2U
	d+ODqi+x3Y7jLrSBxyoJFJ3QOBdy85zg9egrHztivH3JdVTcM5udDO6XRzy5qOLr+SVSTeZC7SR
	xmRZn8AE0yxZ6/arQAv2zJMAtzhN34lGA3lO66IRiYBXIGzi1bLrf0eDxfHOUJMwJiYgMiZMH7F
	ZcN4knxkhudGca7lp3f8WwTDcwHd0C1KTwLrDu9LfVlPi8UcMFuMR6mNp1Jdpq+87lfHhfh8vMe
	E98IqaAI842Qf6VHQQxx4bcuUrz3yRdoI5EGAm/QewsUSI9z8dTJ/n4XObgrgORNmpWVpLWF6
X-Google-Smtp-Source: AGHT+IEaEn0u2JMEtpMZP/T1eIMMHEr1nBIxwAULaJM23pKFbp2ek/MIxJTv8Jgx6joU5+eLWbz96w==
X-Received: by 2002:a17:907:934c:b0:b0a:f3f3:a28 with SMTP id a640c23a62f3a-b3027d3f2b9mr280545366b.14.1758641125343;
        Tue, 23 Sep 2025 08:25:25 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b2636394de6sm1018041266b.39.2025.09.23.08.25.24
        for <sched-ext@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:25:24 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b2e0513433bso304694666b.1
        for <sched-ext@lists.linux.dev>; Tue, 23 Sep 2025 08:25:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW81ep22tjBMslCZi3ifczDgZmvPvVUG3tH2EIk2Uu4gZx7i86TyVG/a0XjPA0DJ2Ybjlw+TPO3H6s=@lists.linux.dev
X-Received: by 2002:a17:907:9287:b0:b07:c815:70a9 with SMTP id
 a640c23a62f3a-b3028427f9fmr264168966b.26.1758641123996; Tue, 23 Sep 2025
 08:25:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <aNF-Mqjnu_phEgvP@slm.duckdns.org> <CAHk-=wj7ps5tNnjMAaz-6uxw6Sbc4PS5PTqREvnnvM6Nzqcq+Q@mail.gmail.com>
 <aNK5ee-9NScZ-l_r@slm.duckdns.org>
In-Reply-To: <aNK5ee-9NScZ-l_r@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Sep 2025 08:25:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjizJtEJtbLJaY5RftBKtM8Cmk8Um1XAeDX2+4dyD6O5w@mail.gmail.com>
X-Gm-Features: AS18NWCoeHg-XTAPe01xE6AHSntJZbmmZSwyabFa5VorL8XVFHeO-_R8V8HVH3I
Message-ID: <CAHk-=wjizJtEJtbLJaY5RftBKtM8Cmk8Um1XAeDX2+4dyD6O5w@mail.gmail.com>
Subject: Re: [GIT PULL] sched_ext: Fixes for v6.17-rc7
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Sept 2025 at 08:15, Tejun Heo <tj@kernel.org> wrote:
>
> No worries. As long as you don't swap e and o in the last name, it's all
> good.

It's a perfectly good garden implement, I'll have you know.

But I'm sorry that I have now caused you to have to stand in line at
the DMV for hours just to get your new name changed on your driver's
license.

Annoying, I know, but it has to be done.

            Linus
