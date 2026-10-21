Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792618349;
	b=pn3xfF+QMmhhFLWSkn5zC8Motw4kYU4TY/4cJor9Gyta3sUIvi0XE1RYZfqLUkl7hX4J
	 LFCY9v49WDK76Toua84x/Pzjt57LFq0MaAwij2PL7WGpOBbk1h/ifw0rG5Hut5l8nN0rS
	 erMWSsHQGlOlnhfqxM78Wh9xgldFNo7TJU5wFFD5lZxwwICtKJsV66kRBZzGUjEmB0XmQ
	 DyWZ+BXUcQi3fWjt/7acKvXckNp/74na3rheNRSYZbRpOQq58A+pb8dvy5/Zml3qfUX9P
	 2bBKdH+ImLty9EjN7gxWoEKeowHHryXRMY+mEbkOBi2snYp7GQRwCjokHmM+/9/9wKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792618349;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=dFTciILOFGJgvYXDbRHb51pHL8SIU8Y3kc2Zay9gqKI=;
	b=EeJUrpu4JqQVoNi63hSnI5UOmhJDcbF9HBcLszr+KA5fJb1zH2MjJ+vaWT/bO9zlLePX
	 GuFaUDUOfX6iqMoZwnp87LANRb/PuF9Qvcka7xfYWA5dVYvteDavplInIssU77ddBFxUM
	 CDsGzrCRC2eZJ4+X+RF8tYfTaoDBcCZ2oPZKZaQJibHWYlZMJhEQfjt9zzlYHFycFxL3l
	 kS+V2Z0TDCkRtjtpcInG46VUbx0LBN/taaek1f7vWMlA5ZPduuxkSWI+Fa9xK1DSdNXqs
	 jHy+fXZQ8IvkIiUeiANE/pmPlsKpaGjoSLEedfzN8Ptq1ds1Tco9qiiMhjhHRukNVJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWTGU2sw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C0606A31B;
	Wed, 21 Oct 2026 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GWTGU2sw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A881F000C1;
	Wed, 21 Oct 2026 21:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792618348;
	bh=dFTciILOFGJgvYXDbRHb51pHL8SIU8Y3kc2Zay9gqKI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GWTGU2swvXbwx486XkoWYqQdy03Lrxp7a4vS9iaBs/3dG8sCGjlLQnyY6IINL1MO0
	 goZ0hFlMYcB7FZXYTbF5CaFSP3fqf5uiwt9kyL33PIjMTAx/8QoaZcIuooj/imXrIS
	 KySLCLcV0KrEj3GR6NVO1H1v9kpXMz26GmhOA1/cj+MHIZI6D07N0vQs+fahMHMTJK
	 SjEbMeQ6nbIRXSxcpat2YxQGiq8MUX0tSy/pzyyIV5yY8CG9NXmY/aAAWeq+OYDG9X
	 cHlZUXR7QwWhXCa7q1NUO/2vRre8jalgwKIzWcJK4S8MM/OcKxNmmZDoByXdwtQwzk
	 a7POuS6Rr41aQ==
Date: Wed, 21 Oct 2026 11:32:27 -1000
Message-ID: <f742ae35affc8c9a1ae0ec61f58dd5d6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Hui Su <sh_def@163.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Reject oversized automatic CID shards
In-Reply-To: <20261021091214.1713830-1-sh_def@163.com>
References: <20261021091214.1713830-1-sh_def@163.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.4-fixes with a note added to the description
that the bug is only reproducible with artificial VM topologies.

Thanks.

--
tejun
