Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A482125BF08
	for <sched-ext@lists.linux.dev>; Wed, 11 Jun 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749647426; cv=none; b=Rxb/ZaTSwVjowRS/sgqNHKi0qZKm942BXXMuaV5UO/MlKWoYXhsnwSg/LEccOYJOqPQekzNcezDCkGiD1QUplk9EZ/lTZa8CUOD/rsSgx9YOUxuJWt3p69rkrSLE36xyKxsYXCepz9LjClsTZ8063hIQL9dkHPCZg8TYnpPtt7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749647426; c=relaxed/simple;
	bh=MP9JEl5qgfsj5Csvrwy+XKAwFV0TOqYFcGNCVuyLZ+k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dGxEHeD4UUxjkt1tsq/7ImdRjvMvzCJCnDsUe/gtz56zR/yLaAhmW+Yx9RVmPUMslRIsLLA5G73+GQLdPbd5M6wsZUKGdzVX2iAEE7KBkEYyTJXHE7DERWBekEyv2ZC4hb+vi1dht8wtFP0nrjeioyi7jxH2GkXscqIJN2SCsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=contractor.linuxfoundation.org; spf=pass smtp.mailfrom=contractor.linuxfoundation.org; dkim=pass (2048-bit key) header.d=contractor.linuxfoundation.org header.i=@contractor.linuxfoundation.org header.b=MDGderyx; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=contractor.linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=contractor.linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=contractor.linuxfoundation.org header.i=@contractor.linuxfoundation.org header.b="MDGderyx"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3105ef2a071so69519061fa.1
        for <sched-ext@lists.linux.dev>; Wed, 11 Jun 2025 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=contractor.linuxfoundation.org; s=google; t=1749647421; x=1750252221; darn=lists.linux.dev;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vussv+d1EuWe9Lo9jvrPtsk0R65hsRjuDhEeaacnxa8=;
        b=MDGderyxq2CCm+fGcj66AAwMJvCK7Qwzc9hI7AyZMxW5EDfO7jD1cDl16qL1jZPcmo
         VIIa+QcsA+OQXW5z1GrxOdG+BLFStwTWysy95cYQt/agyVuq38xVwKkOMuaLlX5iSG3y
         EpxNMAf5tZE6JE/SoJGz5ety+kQflh5krYjjS1ARlkKNpDv9pqz1e1u3uqFaDm04mMwT
         OM1rppWpsXWBnOhSDmi+bETHbDm+MpsHBKr/yzFLl1l73xg6wrQAoR7R1+Locmh8dU2y
         GNOriGKLLXl+JTVpfgKmQsEKfgEtJsyVwcONUbIWjGiPV0kNGVxy2i09Rfb9Y8PJ1A8V
         HG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749647421; x=1750252221;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vussv+d1EuWe9Lo9jvrPtsk0R65hsRjuDhEeaacnxa8=;
        b=roBTJoA4vmtF+lY+642nrUUEXamxwZh/Tpaxn4h4n9DVvZ70B0bsGhrOYCr0iJJLYi
         G803MyFGtTKkfaadoyRNTqvJf21Td19ke6hOL92UQm6pQnzOijiLIPvuDpKofJ/pgZVP
         tZClKxipeyYYNHYam/0Xcrr0HbSOZF6sEo3Ye/1ypr7+J76KkHkWD2ABZ4hnLQqG+rAx
         q4SIcDL/hu/biCM3odk/YpR/Bba/2qp4LrBzSw724ePDc1IRNmueqYwzK7sdWe50lB8L
         4yjcmGIOpBjXG4yazL0ZgC5AZan/5HjgeQViursMjMJ2R7NL4zbhOkUb2JBGuYf5Mdj4
         MCRQ==
X-Gm-Message-State: AOJu0YxQ5FeZl/8h/7F1qNLo+Fstzzwdw+nUvgxhCHgjRPBAXqTQxuOI
	Gj25mWeFEiOfLsAG99HdtQfpx4iGcGlfBgvc/+zrdZ5s7e2YGC79ShDu3s+NVmTZ5CuMcZwUDLH
	yjSJqL6/7noVeEPkDU+geRsvYzyxEcxyjuxJPNqnKO5hVMJ8PHxw2G8Y=
X-Gm-Gg: ASbGncsRgPdQrAwNVMks2VIVvcV3ZfaYaT44XtyjZCCrfVOmTB/HAXns7Oxa0mFzeDD
	sDL58AwcGrVq5s8ISb7lCNXBDyJZuObaAxAy6PwPzU9IBSsdBIx2L3BGoTK1u9KEn7CsLpxRd2w
	cCWE28tL2qX77MBrrZunlHh9fvt/dmJ/cBwJcvrde5Jetm9mHv1ZHTOZ2bZx16pGeNqWd1PxE+v
	uEGSSVTDS+Q8lOy
X-Google-Smtp-Source: AGHT+IHvXupB1UwQl1ouGHwhWNuxrzzpsY6jNc1rNntrVb8qlW1zKweeDZhjcKzOUeBrazYLPX4mtJDbnXLdR4FOAgU=
X-Received: by 2002:a2e:a78a:0:b0:32a:5fb3:60e3 with SMTP id
 38308e7fff4ca-32b223d34b4mr9785131fa.25.1749647421390; Wed, 11 Jun 2025
 06:10:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Shyam Kumar <skachukattu@contractor.linuxfoundation.org>
Date: Wed, 11 Jun 2025 08:10:10 -0500
X-Gm-Features: AX0GCFt2dKFE3IhwmcfuXVVaCEHC9Ks-dxpr_Q3zoQlt3fvqEXWbC5BCw5wkjK0
Message-ID: <CAH=dH98ML_Qec97rVB2i9TwjAHS9_y1XsLkHoa9rbx6Lv-JVzQ@mail.gmail.com>
Subject: Test Mail
To: sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello

This is a test mail.

-- 
Regards
Shyam Kumar
The Linux Foundation Core Projects
